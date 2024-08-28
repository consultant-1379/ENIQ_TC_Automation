import pyodbc, datetime
from bs4 import BeautifulSoup



class Router6k():
    def __init__(self) -> None:
        pass

    def get_all_node_kpi_panel_values(self, web_element, input_json_data):
        soup = BeautifulSoup(web_element, 'html.parser')

        kpi_panel_ui_dict = {}
        ui_nodename = input_json_data.get("Node")
        for block in soup.find_all('div', {"class":"flex-item flex-container-vertical flex-inline-container flex-align-start flex-fill-vertical sf-kpi-tile"}):
            nodename    = self._get_ui_text(block, "div", {"class": "KpiTitle"})
            if ui_nodename == nodename:
                kpi_name    = self._get_ui_text(block, "div", {"class": "KpiActual KpiLast"})
                kpi_value   = self._get_ui_text(block, "div", {"class": "KpiValue"})
                kpi_panel_ui_dict.update({kpi_name:kpi_value})
        return kpi_panel_ui_dict
    
    def compare_kpi_ui_value_with_query(self, kpi_panel_ui_value, input_json_data, start_date, end_date, odbc_name = "NetAn_ODBC"):
        connection = self._connect_to_eniq_db(odbc_name)
        with connection:
            cursor = connection.cursor()
            
            print("kpi_panel_ui_value", kpi_panel_ui_value)
            
            nodename = input_json_data.get("Node")
            _kpi_name = input_json_data.get("KPIs")
            kpi_name    = "Total {_kpi_name} per Node".format(_kpi_name = _kpi_name)
            print("kpi_name", kpi_name)
            ui_kpi_value = str(kpi_panel_ui_value.get(kpi_name))
            print("ui_kpi_value", ui_kpi_value)
            raw_kpi_sum_sql = input_json_data.get("SQL")
            print("raw_kpi_sum_sql", raw_kpi_sum_sql)
            kpi_sum_sql  = raw_kpi_sum_sql.replace("@nodename", nodename).replace("@startdate", start_date).replace("@enddate", end_date)
            print("kpi_sum_sql", kpi_sum_sql)
            kpi_sum_db_value = str(self._fetch_one_value_from_eniq(kpi_sum_sql, cursor))
            
            ui_kpi_value = 'None' if not ui_kpi_value or ui_kpi_value == '(Empty)' or ui_kpi_value == ''  else ui_kpi_value
            return_flag = False if ui_kpi_value != kpi_sum_db_value else True

            print("UI Value: {ui_value}, db value:{kpi_sum_db_value}".format(ui_value = ui_kpi_value, kpi_sum_db_value = kpi_sum_db_value))
            
        return return_flag
    
    def _get_column_values(self, colnames_html, row = 0):
        soup = BeautifulSoup(colnames_html, 'html.parser')
        ui_col_names = {block['column']: self._get_ui_text(block, "div", {"class": "cell-text"}) for block in soup.find_all('div', {"row": str(row)})}
        print("ui_col_names", ui_col_names)
        return ui_col_names

    def validate_Node_Level_KPI_page_filter_data(self, colnames_html):
        col_names = {'Average CPU Usage (%)', 'Average Memory Usage (%)', 'ENERGY_METER', 'MOID', 'NE_NAME', 'OSS_ID', 'Peak CPU Usage (%)', 'Peak Memory Usage (%)', 'average_user_mem', 'cpu_usage', 'free_user_mem', 'load_average', 'peak_cpu', 'peak_user_mem', 'pmMaxPowerConsumption', 'pmPowerConsumption', 'total_user_mem', 'DATE_ID'}
        ui_col_names = (self._get_column_values(colnames_html)).values()
        print("ui_col_names", ui_col_names)
        difference = col_names - set(ui_col_names)
        return_status = False if difference else True
        return return_status

    def validate_Interface_Level_KPI_page_filter_data(self, colnames_html):
        col_names = {'NE_NAME', 'Ethernet Interface Ingress Discard Ratio (%)', 'portspeed', 'Ingress Total Packets (n)', 'ifInDiscardPkts', 'DL Throughput (Mbps)', 'Ethernet Ingress Multicast Frames (%)', 'outoctets', 'inpackets', 'PERIOD_DURATION', 'Ethernet Interface Ingress Error Ratio (%)', 'Egress Total Packets (n)', 'Egress Multicast Packets (n)', 'UL Throughput (Mbps)', 'ifOutDiscardPkts', 'outoctets_per_sec', 'Ethernet Interface Queue Drop Ratio (%)', 'MOID', 'inoctets', 'Ethernet Ingress Link Utilization (%)', 'Ingress Multicast Packets (n)', 'queue_tx_total_bytes', 'Ethernet Interface Egress Error Ratio (%)', 'SN', 'Ethernet Egress Multicast Frames (%)', 'Capacity (Mbps)', 'OSS_ID', 'Ethernet Egress Link Utilization (%)', 'inoctets_per_sec', 'mcast_outpackets', 'Full Duplex Utilization (%)', 'ifInErrorPkts', 'queue_drop_total_bytes', 'mcast_inpackets', 'FINALINTERFACE', 'outpackets', 'ifOutErrorPkts', 'Ethernet Interface Egress Discard Ratio (%)'}
        ui_col_names = (self._get_column_values(colnames_html)).values()
        print("ui_col_names", ui_col_names)
        difference = col_names - set(ui_col_names)
        return_status = False if difference else True
        return return_status
    
    def get_first_row_data_from_data_table(self, row_headers_html, row_data_html, row_number):
        ui_col_names = self._get_column_values(row_headers_html)
        ui_data = self._get_column_values(row_data_html, row_number)
        zipped_value = {value: ui_data.get(key) for key, value in ui_col_names.items()}
        print("zipped_value", zipped_value)
        return dict(zipped_value)
    
    def convert_datetime(self, inputdate, current_timeformat = r"%m/%d/%Y %I:%M:%S %p", expected_format = r"%Y-%m-%d %H:%M:%S"):
        print("inputdate:", inputdate)
        try:
            trimmed_format = current_timeformat if ("am" in inputdate.lower() or "pm" in inputdate.lower()) else current_timeformat.replace(" %p", "").replace("%I", "%H")
            print("trimmed_format", trimmed_format)
            datetime_id = datetime.datetime.strptime(inputdate, trimmed_format).strftime(expected_format)
        except ValueError:
            print("Exception 85")
            if " " in inputdate:
                current_timeformat  = r"%d/%m/%Y %I:%M:%S %p" if "am" in inputdate.lower() or "pm" in inputdate.lower() else r"%d/%m/%Y %H:%M:%S"
                expected_format     = r"%Y-%m-%d %H:%M:%S"
            else:
                current_timeformat  = r"%d/%m/%Y" 
                expected_format     = r"%Y-%m-%d"
            datetime_id = datetime.datetime.strptime(inputdate, current_timeformat).strftime(expected_format)
        print("datetime_id:", datetime_id)
        return datetime_id

    def _prepare_sql_query(self, ui_row_data, input_json):
        raw_sql = input_json.get("SQL")
        nodename= ui_row_data.get("NE_NAME")
        ui_datetime = ui_row_data.get("DATETIME_ID") if "DATETIME_ID" in ui_row_data else ui_row_data.get("DATE_ID")
        start_date  = self.convert_datetime(ui_datetime)
        sql_string  = raw_sql.replace("@nodename", nodename).replace("@startdate", start_date)
        print("sql_string:", sql_string)
        return sql_string

    def verify_ui_data_with_sql(self, ui_row_data, input_json, odbc_name = "NetAn_ODBC"):
        connection  = self._connect_to_eniq_db(odbc_name)
        sql_string  = self._prepare_sql_query(ui_row_data, input_json)
        print("sql_string")
        kpi_name    = input_json.get("KPIs")
        ui_kpi_data = ui_row_data.get(kpi_name)
        with connection:
            cursor = connection.cursor()
            result_set = self._fetch_one_value_from_eniq(sql_string, cursor)
        ui_kpi_data = None if not ui_kpi_data else ui_kpi_data
        print("result_set:", result_set)
        print("ui_kpi_data:", ui_kpi_data)
        return str(result_set) == str(ui_kpi_data)
    
    def _get_ui_text(self, soup_object, tagname, attributes):
        return ((soup_object.find(tagname, attributes)).get_text()).strip()

    def _connect_to_eniq_db(self, odbc_name = "NetAn_ODBC"):
        return pyodbc.connect("DSN={odbc_name}".format(odbc_name = odbc_name))

    def _fetch_from_eniq(self, sql_string, cursor):
        cursor.execute(sql_string)
        all_data = cursor.fetchall()
        return all_data
    
    def _fetch_one_value_from_eniq(self, sql_string, cursor):
        cursor.execute(sql_string)
        all_data = cursor.fetchone()
        return all_data[0]

