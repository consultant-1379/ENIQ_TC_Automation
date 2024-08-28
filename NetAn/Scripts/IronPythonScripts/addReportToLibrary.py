# ********************************************************************
# Ericsson Inc.                                                 SCRIPT
# ********************************************************************
#
#
# (c) Ericsson Inc. 2021 - All rights reserved.
#
# The copyright to the computer program(s) herein is the property
# of Ericsson Inc. The programs may be used and/or copied only with
# the written permission from Ericsson Inc. or in accordance with the
# terms and conditions stipulated in the agreement/contract under
# which the program(s) have been supplied.
#
# ********************************************************************
# Name    : AddReportToLibrary.py
# Date    : 23/08/2021
# Revision: 1.0
# Purpose : 
#
# Usage   : PM Explorer
#

import clr
clr.AddReference('System.Data')
clr.AddReference("System.Windows.Forms")

from Spotfire.Dxp.Data import *
from Spotfire.Dxp.Application.Visuals import *
from Spotfire.Dxp.Data.DataOperations import *
from Spotfire.Dxp.Framework.Library import *
from Spotfire.Dxp.Application.Filters import *
import Spotfire.Dxp.Application.Filters as filters
from Spotfire.Dxp.Data.Import import TextFileDataSource, TextDataReaderSettings
from Spotfire.Dxp.Framework.ApplicationModel import NotificationService

from System import Array, Byte, Guid
from System.IO import MemoryStream, SeekOrigin, StreamWriter
from System.Data.Odbc import OdbcConnection
from System.Text import UTF8Encoding
from System.Security.Cryptography import RijndaelManaged, CryptoStream, CryptoStreamMode
from System.Windows.Forms import MessageBox,MessageBoxButtons,SaveFileDialog, DialogResult
from System.Collections.Generic import List

import json
from json import JSONEncoder
import ast
import re
import datetime

#Pages and tables in PmEx to be ignored during serialization. (Used if not table/graph selection is to be given in report mgr)
pmex_table_list = ['Intervals','Node Collections','Datetime Interval Definitions','NodeCollection','NodeList','SelectedNodes','Measures','Measure Mapping','Measure Mapping (All)', 'Measure Mapping (Selected)','Counter Mapping','NodeListMeasure','Alarm Definitions','ENIQ Counters','DayOFWeek','ReportLibrary - ReportDetails','GraphList','tblSavedReports','TableList','MeasuresInReport','PageReportMap','ObjAggLevelTable','Topology Data','FDNSubnetworkList from ENIQ','SubNetwork List','Modified Topology Data','Wildcard Collections','ENIQ TopologyTable','OperationsLists','OperationsLists2','Dynamiccollectontable', 'ENIQDataSources', 'AggregateTable', 'FolderList']
pmex_page_list = ['Home', 'Administration', 'Manage Collection', 'Create Collection','Create  Collection','Measure Selection', 'Measure Manager', 'Report Manager', 'HolderPage', 'HolderPage2','Save Report','Holder','Holder2','Page','Create Information Link(s)']
visual_titles_exceptions = ['NavControlsInEditMode','EditNavForRepMgr','Edit Selections','Generate Panel Edit','Mode Banner','Edit Selections time']

user_name = Document.Properties['UserName']
measure_mapping_selected_dt = Document.Data.Tables['Measure Mapping (Selected)']
page_report_map_dt = Document.Data.Tables['PageReportMap']

_key    = ast.literal_eval(Document.Properties['valArray'])
_vector = [0, 0, 0, 0, 0, 0, 0, 0,
           0, 0, 0, 0, 0, 0, 0, 0]

_key = Array[Byte](_key)
_vector = Array[Byte](_vector)

notify = Application.GetService[NotificationService]()

report_table_list = []
report_table_list_json = []


class SavedReportColumn: 
    ReportName  = 'ReportName'
    ReportDescription = 'ReportDescription'
    ReportAccess= 'ReportAccess'
    TableList   = 'TableList'
    GraphList   = 'GraphList'
    EniqName    = 'ENIQName'

class ReportMetaData:  
    def __init__(self, reportDescription, reportAccess):
        self.ReportDescription = reportDescription
        self.ReportAccess = reportAccess

class Page:  
    def __init__(self, pageName, Graphs):
        self.pageName = pageName
        self.GraphList = Graphs


class Report:
    def __init__(self,reportName, ReportMetaData, Page,Tables):
        self.ReportName = reportName
        self.ReportMetaData = ReportMetaData
        self.PageList = Page 
        self.TableList = Tables
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class ShowHideItems:
    def __init__(self,ThresholdRuleConditionMetaData,TopBottomRuleConditionMetaData,StringRuleConditionMetaData,RangeRuleConditionMetaData,ExpressionRuleConditionMetaData):
        self.ThresholdRuleConditionMetaDataList = ThresholdRuleConditionMetaData 
        self.TopBottomRuleConditionMetaDataList = TopBottomRuleConditionMetaData
        self.StringRuleConditionMetaDataList = StringRuleConditionMetaData
        self.RangeRuleConditionMetaDataList = RangeRuleConditionMetaData 
        self.ExpressionRuleConditionMetaDataList = ExpressionRuleConditionMetaData 
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class TopBottomRuleMetaData:
    def __init__(self, params):
        self.DisplayName = params.get('display_name')
        self.Expression = params.get('expression')
        self.RuleConditionIsBottom = params.get('rule_condition_is_bottom')
        self.RuleConditionRankType = params.get('rule_condition_rank_type')
        self.RuleConditionRankValue = params.get('rule_condition_rank_value')
        self.RuleConditionRankManualDisplayName = params.get('rule_condition_rank_manual_display_name')
        self.HideMatchedItems = params.get('hide_matched_items') 
        self.EvaluatePerTrellis = params.get('evaluate_per_trellis')
        self.Enabled = params.get('enabled')


class ThresholdRuleMetaData:
    def __init__(self, params):
        self.DisplayName = params.get('display_name')
        self.Expression = params.get('expression')
        self.RuleConditionComparisonOperator = params.get('rule_condition_comparison_operator')
        self.RuleConditionThresholdType = params.get('rule_condition_threshold_type')
        self.RuleConditionThresholdValue = params.get('rule_condition_threshold_value')
        self.RuleConditionThresholdManualDisplayName = params.get('rule_condition_threshold_manual_display_name')
        self.HideMatchedItems = params.get('hide_matched_items') 
        self.EvaluatePerTrellis = params.get('evaluate_per_trellis')
        self.Enabled = params.get('enabled')


class StringRuleMetaData:
    def __init__(self, params):
        self.DisplayName = params.get('display_name')
        self.Expression = params.get('expression')
        self.RuleConditionComparisonOperator = params.get('rule_condition_comparison_operator')
        self.RuleConditionStringValueType = params.get('rule_condition_string_type')
        self.RuleConditionStringValue = params.get('rule_condition_string_value')
        self.RuleConditionStringValueManualDisplayName = params.get('rule_condition_string_manual_display_name')
        self.HideMatchedItems = params.get('hide_matched_items') 
        self.EvaluatePerTrellis = params.get('evaluate_per_trellis')
        self.Enabled = params.get('enabled')


class RangeRuleMetaData:
    def __init__(self, params):
        self.DisplayName = params.get('display_name')
        self.Expression = params.get('expression')
        self.RuleConditionEndValueType = params.get('rule_condition_end_value_type')
        self.RuleConditionEndValueValue = params.get('rule_condition_end_value_value')
        self.RuleConditionStartValueType = params.get('rule_condition_start_value_type')
        self.RuleConditionStartValueValue = params.get('rule_condition_start_value_value')
        self.RuleConditionEndValueManualDisplayName = params.get('rule_condition_end_value_manual_display_name')
        self.RuleConditionStartValueManualDisplayName = params.get('rule_condition_start_value_manual_display_name')
        self.HideMatchedItems = params.get('hide_matched_items') 
        self.EvaluatePerTrellis = params.get('evaluate_per_trellis')
        self.Enabled = params.get('enabled')


class ExpressionRuleMetaData:
    def __init__(self, params):
        self.DisplayName = params.get('display_name')
        self.Expression = params.get('expression')
        self.RuleConditionExpression = params.get('rule_condition_expression')
        self.HideMatchedItems = params.get('hide_matched_items') 
        self.EvaluatePerTrellis = params.get('evaluate_per_trellis')
        self.Enabled = params.get('enabled')


class Graphs:
    def __init__(self,TablePlotMetaData,BarGraphMetaData,LineGraphMetaData, CrossTableMetaData, PieChartMetaData, ScatterPlotMetaData, HeatMapMetaData, CombinationChartMetaData, BoxPlotMetaData, SummaryTableMetaData, TreeMapMetaData, KpiChartMetaData):
        self.TablePlotMetaDataList = TablePlotMetaData 
        self.BarGraphMetaDataList = BarGraphMetaData 
        self.LineGraphMetaDataList = LineGraphMetaData
        self.CrossTableMetaDataList = CrossTableMetaData 
        self.PieChartMetaDataList = PieChartMetaData
        self.ScatterPlotMetaDataList = ScatterPlotMetaData
        self.HeatMapMetaDataList = HeatMapMetaData
        self.CombinationChartMetaDataList = CombinationChartMetaData
        self.BoxPlotMetaDataList = BoxPlotMetaData
        self.SummaryTableMetaDataList = SummaryTableMetaData
        self.TreeMapMetaDataList = TreeMapMetaData
        self.KpiChartMetaDataList = KpiChartMetaData
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class TablePlotMetaData: 
    def __init__(self, params):
        self.graphName = params.get('chart_title')
        self.tableReferenceName = params.get('table_name')
        self.showTitle = params.get('show_title')
        self.Description = params.get('description')
        self.showDescription = params.get('show_description')
        self.headerHeight = params.get('header_height')
        self.rowHeight = params.get('row_height')
        self.frozenCount = params.get('frozen_count')
        self.cellBorderStyle = params.get('cell_border_style')
        self.exportDataEnabled = params.get('export_data_enabled')
        self.useSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.DataFilters = params.get('data_filters')
        self.legend_obj = params.get('legend_obj')
        self.ShowHideItems = params.get('show_hide_items')


class BarGraphMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.Description = params.get('description')
        self.showDescription = params.get('show_description')
        self.Layout = params.get('layout')
        self.labelVisibility = params.get('label_visibility')
        self.labelOrientation = params.get('label_orientation')
        self.labelCompleteBar = params.get('label_complete_bar')
        self.labelSegments = params.get('label_segments')
        self.segmentLabelInformationType = params.get('segment_label_information_type')
        self.maxNumberOfLabels = params.get('max_number_of_labels')
        self.labelPercentageDecimalDigits = params.get('label_percentage_decimal_digits')
        self.legendObject = params.get('legend_obj')
        self.ShowHideItems = params.get('show_hide_items')
        self.tableName = params.get('table_name') #table_ref_name
        self.xAxis = params.get('x_axis')
        self.yAxis = params.get('y_axis')
        self.BarWidth = params.get('bar_width') 
        self.ShowShadowBars = params.get('show_shadow_bars')
        self.Transparency = params.get('transparency')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.SortedBars = params.get('sorted_bars')
        self.SortSegmentsBySize = params.get('sort_segments_by_size')
        self.ReverseSegmentOrder = params.get('reverse_segment_order')
        self.CompensateForMissingTimeSeriesValues = params.get('compensate_for_missing_time_series_values')
        self.Orientation = params.get('orientation')
        self.Trellis = params.get('trellis')
        self.ColorAxis = params.get('color_axis')
        self.FittingModels = params.get('fitting_models')
        self.DataFilters = params.get('data_filters')
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class LineGraphMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name') #table_ref_name
        self.xAxis = params.get('x_axis')
        self.yAxis = params.get('y_axis')
        self.LineWidth = params.get('line_width')
        self.legendObject = params.get('legend_obj')
        self.ShowHideItems = params.get('show_hide_items')
        self.labelVisibility = params.get('label_visibility')
        self.Transparency = params.get('transparency')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.CompensateForMissingTimeSeriesValues = params.get('compensate_for_missing_time_series_values')
        self.BreakOnEmpty = params.get('break_on_empty')
        self.LineByAxisExpr = params.get('line_by_axis_expression')
        self.SteppedLines = params.get('stepped_lines')
        self.ShowMarkers = params.get('show_markers')
        self.MarkerSize = params.get('marker_size')
        self.Description = params.get('description')
        self.MaxNumberOfLabels = params.get('max_number_of_labels')
        self.ShowDescription = params.get('show_description')
        self.ShowIndividualScaling = params.get('show_individual_scaling')
        self.ShowLineLabels = params.get('show_line_labels')
        self.ShowMarkerLabels = params.get('show_marker_labels')
        self.Trellis = params.get('trellis')
        self.ColorAxis = params.get('color_axis')
        self.FittingModels = params.get('fitting_models') 
        self.DataFilters = params.get('data_filters')
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class CombinationChartMetaData: #Add table object
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name')
        self.xAxis = params.get('x_axis')
        self.yAxis = params.get('y_axis')
        self.Transparency = params.get('transparency')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.CompensateForMissingTimeSeriesValues = params.get('compensate_for_missing_time_series_values')
        self.Description = params.get('description')
        self.MaxNumberOfLabels = params.get('max_number_of_labels')
        self.ShowDescription = params.get('show_description')
        self.ShowMarkerLabels = params.get('show_marker_labels')
        self.BarsLabelCompleteBar = params.get('bars_label_complete_bar')
        self.BarsLabelOrientation = params.get('bars_label_orientation')
        self.BarsReverseSegmentOrder = params.get('bars_reverse_segment_order')
        self.BarsStackMode = params.get('bars_stack_mode')
        self.BarsWidth = params.get('bars_width')
        self.LabelVisibility = params.get('label_visibility')
        self.LinesBreakOnEmpty = params.get('lines_break_on_empty')
        self.LinesMarkerSize = params.get('lines_marker_size')
        self.LinesShowMarkerLabels = params.get('lines_show_marker_labels')
        self.LinesShowMarkers = params.get('lines_show_markers')
        self.LinesSteppedLines = params.get('lines_stepped_lines')
        self.LinesWidth = params.get('lines_width')
        self.SeriesLegendItemShowAxisSelector = params.get('series_legend_item_show_axis_selector')
        self.SeriesLegendItemShowTitle = params.get('series_legend_item_show_title')
        self.SeriesLegendItemTitle = params.get('series_legend_item_title')
        self.SeriesLegendItemVisible = params.get('series_legend_item_visible')
        self.SeriesTypeYAxis = params.get('series_type_y_axis')
        self.SeriesTypeXAxis = params.get('series_type_x_axis')
        self.SeriesTypeColorAxis = params.get('series_type_color_axis')
        self.ShowHideItems = params.get('show_hide_items')
        self.SortByCategoryKey = params.get('sort_by_category_key')
        self.Trellis = params.get('trellis')
        self.ColorAxis = params.get('color_axis')
        self.FittingModels = params.get('fitting_models')
        self.DataFilters = params.get('data_filters')


class CrossTableMetaData:
    def __init__(self, params):
        self.page_name = params.get('page_name')
        self.chart_title = params.get('chart_title')
        self.show_title = params.get('show_title')
        self.table_name = params.get('table_name')
        self.col_axis = params.get('col_axis')
        self.col_axis_mode = params.get('col_axis_mode')
        self.col_axis_name = params.get('col_axis_name')
        self.col_axis_evaluation_mode = params.get('col_axis_evaluation_mode')
        self.col_sub_totals_layout = params.get('col_sub_totals_layout')
        self.empty_cell_text = params.get('empty_cell_text')
        self.export_enabled = params.get('export_enabled')
        self.indicate_hidden_cols = params.get('indicate_hidden_cols')
        self.indicate_hidden_rows = params.get('indicate_hidden_rows')
        self.legend = params.get('legend')
        self.measure_axis = params.get('measure_axis')
        self.measure_axis_name = params.get('measure_axis_name')
        self.row_axis = params.get('row_axis')
        self.row_axis_name = params.get('row_axis_name')
        self.show_axis_selectors = params.get('show_axis_selectors')
        self.show_col_grand_total = params.get('show_col_grand_total')
        self.show_cont_color = params.get('show_cont_color')
        self.show_gridlines = params.get('show_gridlines')
        self.show_row_grand_total = params.get('show_row_grand_total')
        self.show_top_n_cols = params.get('show_top_n_cols')
        self.show_top_n_rows = params.get('show_top_n_rows')
        self.sort_cols_cat = params.get('sort_cols_cat')
        self.sort_cols_order = params.get('sort_cols_order')
        self.sort_rows_cat = params.get('sort_rows_cat')
        self.sort_rows_mode = params.get('sort_rows_mode')
        self.sort_rows_order = params.get('sort_rows_order')
        self.supports_transparency = params.get('supports_transparency')
        self.transparency = params.get('transparency')
        self.top_n_col_count = params.get('top_n_col_count')
        self.top_n_row_count = params.get('top_n_row_count')
        self.DataFilters = params.get('data_filters')
        self.ShowHideItems = params.get('show_hide_items')
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class PieChartMetaData:
    def __init__(self, params):
        self.page_name = params.get('page_name')
        self.chart_title = params.get('chart_title')
        self.show_title = params.get('show_title')
        self.table_name = params.get('table_name')
        self.description = params.get('description')
        self.marker_size = params.get('marker_size')
        self.sector_axis_mode = params.get('sector_axis_mode')
        self.sector_expression = params.get('sector_expression')
        self.sector_evaluation_mode = params.get('sector_evaluation_mode')
        self.sector_category_mode = params.get('sector_category_mode')
        self.sector_name = params.get('sector_name')
        self.show_description = params.get('show_description')
        self.size_axis_mode = params.get('size_axis_mode')
        self.size_binding = params.get('size_binding')
        self.size_category_mode = params.get('size_category_mode')
        self.size_evaluation_mode = params.get('size_evaluation_mode')
        self.size_data_expression = params.get('size_data_expression')
        self.size_name = params.get('size_name')
        self.size_high_range = params.get('size_high_range')
        self.size_low_range = params.get('size_low_range')
        self.size_scale_type = params.get('size_scale_type')
        self.supports_transparency = params.get('supports_transparency')
        self.transparency = params.get('transparency')
        self.use_separate_color_for_marked_items = params.get('use_separate_color_for_marked_items')
        self.label_category = params.get('label_category')
        self.label_percentage = params.get('label_percentage')
        self.label_percentage_decimal_digits = params.get('label_percentage_decimal_digits')
        self.label_percentage_limit = params.get('label_percentage_limit')
        self.label_position = params.get('label_position')
        self.label_value = params.get('label_value')
        self.label_visibility = params.get('label_visibility')
        self.max_number_of_labels = params.get('max_number_of_labels')
        self.sort_sectors_by_size = params.get('sort_sectors_by_size')
        self.legend_obj = params.get('legend_obj')
        self.DataFilters = params.get('data_filters')
        self.Trellis = params.get('trellis')
        self.ColorAxis = params.get('color_axis')
        self.ShowHideItems = params.get('show_hide_items')
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class ScatterPlotMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name')
        self.xAxis = params.get('x_axis')
        self.yAxis = params.get('y_axis')
        self.xJitter = params.get('x_jitter')
        self.yJitter = params.get('y_jitter')
        self.Transparency = params.get('transparency')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.LineConnection = params.get('line_connection')
        self.MarkerByAxisExpr = params.get('marker_by_axis_expression')
        self.MarkerClass = params.get('marker_class')
        self.MarkerLabelLayout = params.get('marker_label_layout')
        self.MarkerSize = params.get('marker_size')
        self.Description = params.get('description')
        self.DrawingOrderAxisExpr = params.get('drawing_order_axis')
        self.DrawingOrderReversed = params.get('drawing_order_reversed')
        self.MaxNumberOfLabels = params.get('max_number_of_labels')
        self.LabelColumn = params.get('label_column'),
        self.LabelVisibility = params.get('label_visibility'),
        self.PieMarker = params.get('pie_marker')
        self.RotationAxis = params.get('rotation_axis')
        self.RotateClockwise = params.get('rotate_clockwise')
        self.ShapeAxis = params.get('shape_axis')
        self.ShowDescription = params.get('show_description')
        self.ShowEmptyLabels = params.get('show_empty_labels')
        self.ShowStraightLineFit = params.get('show_straight_line_fit')
        self.SizeAxis = params.get('size_axis')
        self.Trellis = params.get('trellis')
        self.ColorAxis = params.get('color_axis')
        self.FittingModels = params.get('fitting_models')
        self.DataFilters = params.get('data_filters')
        self.legend_obj = params.get('legend_obj')
        self.ShowHideItems = params.get('show_hide_items')


class HeatMapMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.Description = params.get('description')
        self.ShowDescription = params.get('show_description')
        self.Trellis = params.get('trellis')
        self.DataFilters = params.get('data_filters')
        self.legend_obj = params.get('legend_obj')
        self.x_axis = params.get('x_axis')
        self.y_axis = params.get('y_axis')
        self.sort_by = params.get('sort_by')
        self.sort_order = params.get('sort_order')
        self.color_category = params.get('color_category')
        self.col_dendrogram_visible = params.get('col_dendrogram_visible')
        self.col_data_table_ref = params.get('col_data_table_ref')
        self.col_dendogram_man_update = params.get('col_dendogram_man_update')
        self.col_dendrogram_dock = params.get('col_dendrogram_dock')
        self.col_dendogram_pruning_colorA = params.get('col_dendogram_pruning_colorA')
        self.col_dendogram_pruning_colorB = params.get('col_dendogram_pruning_colorB')
        self.col_dendogram_pruning_level = params.get('col_dendogram_pruning_level')
        self.col_dendogram_pruning_line_color = params.get('col_dendogram_pruning_line_color')
        self.col_dendogram_show_pruning_line = params.get('col_dendogram_show_pruning_line')
        self.col_dendogram_man_use_data_table = params.get('col_dendogram_man_use_data_table')
        self.row_dendrogram_visible = params.get('row_dendrogram_visible')
        self.row_data_table_ref = params.get('row_data_table_ref')
        self.row_dendogram_man_update = params.get('row_dendogram_man_update')
        self.row_dendrogram_dock = params.get('row_dendrogram_dock')
        self.row_dendogram_pruning_colorA = params.get('row_dendogram_pruning_colorA')
        self.row_dendogram_pruning_colorB = params.get('row_dendogram_pruning_colorB')
        self.row_dendogram_pruning_level = params.get('row_dendogram_pruning_level')
        self.row_dendogram_pruning_line_color = params.get('row_dendogram_pruning_line_color')
        self.row_dendogram_show_pruning_line = params.get('row_dendogram_show_pruning_line')
        self.row_dendogram_man_use_data_table = params.get('row_dendogram_man_use_data_table')
        self.measure_axis_cat_mode = params.get('measure_axis_cat_mode')
        self.measure_axis_eval_mode = params.get('measure_axis_eval_mode')
        self.measure_axis_expression = params.get('measure_axis_expression')
        self.ShowHideItems = params.get('show_hide_items')
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class BoxPlotMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.Description = params.get('description')
        self.ShowDescription = params.get('show_description')
        self.Trellis = params.get('trellis')
        self.DataFilters = params.get('data_filters')
        self.legend_obj = params.get('legend_obj')
        self.x_axis = params.get('x_axis')
        self.y_axis = params.get('y_axis')
        self.ColorAxis = params.get('color_axis')
        self.FittingModels = params.get('fitting_models')
        self.box_width = params.get('box_width')
        self.comparison_circles_alpha_level = params.get('comparison_circles_alpha_level')
        self.comparison_circles_span = params.get('comparison_circles_span')
        self.comparison_circles_visible = params.get('comparison_circles_visible')
        self.marker_size = params.get('marker_size')
        self.show_95_perc_confidence = params.get('show_95_perc_confidence')
        self.show_distribution = params.get('show_distribution')
        self.table_measures = params.get('table_measures')
        self.table_show_gridlines = params.get('table_show_gridlines')
        self.table_sort_measure = params.get('table_sort_measure')
        self.table_sort_mode = params.get('table_sort_mode')
        self.table_visible = params.get('table_visible')
        self.x_jitter = params.get('x_jitter')
        self.transparency = params.get('transparency')
        self.use_relative_scale = params.get('use_relative_scale')
    def toJSON(self):
        return json.dumps(self, default=lambda o: o.__dict__, indent=4)


class SummaryTableMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name')
        self.Aggregations = params.get('aggregations')
        self.AutoAddNewColumns = params.get('auto_add_new_columns')
        self.CategoryAxis = params.get('category_axis')
        self.Columns = params.get('columns')
        self.DataFilters = params.get('data_filters')
        self.Description = params.get('description')
        self.ExportDataEnabled = params.get('export_data_enabled')
        self.FirstColumnWidth = params.get('first_column_width')
        self.FirstRowHeight = params.get('first_row_height')
        self.legend_obj = params.get('legend_obj')
        self.ShowDescription = params.get('show_description')
        self.ShowGridlines = params.get('show_gridlines')
        self.SortColumn = params.get('sort_column')
        self.SortOrder = params.get('sort_order')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')


class TreeMapMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name')
        self.DataFilters = params.get('data_filters')
        self.Description = params.get('description')
        self.legend_obj = params.get('legend_obj')
        self.ColorAxis = params.get('color_axis')
        self.Trellis = params.get('trellis')
        self.ShowDescription = params.get('show_description')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.hierarchy_axis_mode = params.get('hierarchy_axis_mode')
        self.hierarchy_axis_category_mode = params.get('hierarchy_axis_category_mode')
        self.hierarchy_axis_evaluation_mode = params.get('hierarchy_axis_evaluation_mode')
        self.hierarchy_axis_expression = params.get('hierarchy_axis_expression')
        self.hierarchy_axis_name = params.get('hierarchy_axis_name')
        self.show_hierarchy_headers = params.get('show_hierarchy_headers')
        self.show_labels = params.get('show_labels')
        self.ShowHideItems = params.get('show_hide_items')
        self.size_axis_mode = params.get('size_axis_mode')
        self.size_axis_category_mode = params.get('size_axis_category_mode')
        self.size_axis_evaluation_mode = params.get('size_axis_evaluation_mode')
        self.size_axis_expression = params.get('size_axis_expression')
        self.size_axis_name = params.get('size_axis_name')


class KpiChartMetaData:
    def __init__(self, params):
        self.pageName = params.get('page_name')
        self.graphName = params.get('chart_title')
        self.showTitle = params.get('show_title')
        self.tableName = params.get('table_name')
        self.ActiveKpi = params.get('active_kpi')
        self.DataFilters = params.get('data_filters')
        self.Description = params.get('description')  
        self.KpiCollection = params.get('kpi_collection')
        self.PreferredTileWidth = params.get('preferred_tile_width')
        self.ShowDescription = params.get('show_description')
        self.SortMode = params.get('sort_mode')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')


class KpiVisualizationMetaData:
    def __init__(self, params):
        self.ColorAxis = params.get('color_axis')
        self.ComparativeAxis = params.get('comparative_axis')
        self.Description = params.get('description')
        self.EmptyTileColor = params.get('empty_tile_color')
        self.EmptyTileText = params.get('empty_tile_text')
        self.IncludeOrigin = params.get('include_origin')
        self.ShowDescription = params.get('show_description')
        self.ShowHideItems = params.get('show_hide_items')
        self.ShowSparkline = params.get('show_sparkline')
        self.ShowSparklineScale = params.get('show_sparkline_scale')
        self.ShowXLabelInTile = params.get('show_x_label_in_tile')
        self.SortColumn = params.get('sort_column')
        self.TableName = params.get('data_table_ref')
        self.TileAxis = params.get('tile_axis')
        self.Title = params.get('title')
        self.UseSeparateColorForMarkedItems = params.get('use_separate_color_for_marked_items')
        self.XAxis = params.get('x_axis')
        self.YAxis = params.get('y_axis')


class DataFilters:
    def __init__(self,Markings,DataLimiting,FilteringScheme):
        self.Markings = Markings
        self.DataLimiting = DataLimiting
        self.FilteringScheme = FilteringScheme


class DataLimiting:
    def __init__(self,combinationMethod,limitbyMarking,limitbyFilter,limitbyExpression,limitEmptyBehavior,limitEmptyMessage):
        self.combinationMethod = combinationMethod
        self.limitbyMarkingList = limitbyMarking
        self.limitbyFilteringSchemeList = limitbyFilter
        self.limitbyExpression = limitbyExpression
        self.LimitingMarkingsEmptyBehavior = limitEmptyBehavior
        self.LimitingMarkingsEmptyMessage = limitEmptyMessage


class Trellis:
    def __init__(self,TrellisMode, manualColumnCount, manualLayout,manualRowCount,panelAxis,pageAxis,rowAxis,colAxis,colAxisAxisMod,colAxisCategoryMode,colAxisEvaluationMode,pageAxisAxisMod,pageAxisCategoryMode,pageAxisEvaluationMode,rowAxisAxisMod,rowAxisCategoryMode,rowAxisEvaluationMode,panelAxisAxisMod,panelAxisCategoryMode,panelAxisEvaluationMode):
        self.trellisMode = TrellisMode
        self.manualColumnCount = manualColumnCount
        self.manualLayout = manualLayout
        self.manualRowCount = manualRowCount
        self.panelAxis = panelAxis
        self.pageAxis = pageAxis
        self.rowAxis = rowAxis
        self.colAxis = colAxis
        self.colAxisAxisMod = colAxisAxisMod
        self.colAxisCategoryMode = colAxisCategoryMode
        self.colAxisEvaluationMode = colAxisEvaluationMode
        self.pageAxisAxisMod = pageAxisAxisMod
        self.pageAxisCategoryMode = pageAxisCategoryMode
        self.pageAxisEvaluationMode = pageAxisEvaluationMode
        self.rowAxisAxisMod = rowAxisAxisMod
        self.rowAxisCategoryMode = rowAxisCategoryMode
        self.rowAxisEvaluationMode = rowAxisEvaluationMode
        self.panelAxisAxisMod = panelAxisAxisMod
        self.panelAxisCategoryMode = panelAxisCategoryMode
        self.panelAxisEvaluationMode = panelAxisEvaluationMode
        
class FittingModel:
    def __init__(self, fitting_model_dict):
        self.name = fitting_model_dict['name']
        self.AssumedXTransformType = fitting_model_dict['assumed_x_transform_type']
        self.Amplitude = fitting_model_dict['amplitude']
        self.AmplitudeIsFixed = fitting_model_dict['amplitude_is_fixed']
        self.CurveLine = fitting_model_dict['curve_line']
        self.DisplayName = fitting_model_dict['display_name']
        self.Degree = fitting_model_dict['degree']
        self.Enabled = fitting_model_dict['enabled']
        self.Expression = fitting_model_dict['expression']
        self.FixedMin = fitting_model_dict['fixed_min']
        self.FixedMax = fitting_model_dict['fixed_max']
        self.HasFixedMin = fitting_model_dict['has_fixed_min']
        self.HasFixedMax = fitting_model_dict['has_fixed_max']
        self.IndividualFittingMode = fitting_model_dict['individual_fitting_mode']
        self.InflectionPoint = fitting_model_dict['inflection_point']
        self.IsHorizontal = fitting_model_dict['is_horizontal']
        self.ManualUpdate = fitting_model_dict['manual_update']
        self.Position = fitting_model_dict['position']
        self.PositionIsFixed = fitting_model_dict['position_is_fixed']
        self.Width = fitting_model_dict['width']
        self.WidthIsFixed = fitting_model_dict['width_is_fixed']
        self.AllowEmptyValueReplacement = fitting_model_dict['allow_empty_value_replacement']
        self.AutomaticFrequency = fitting_model_dict['automatic_frequency']
        self.ConfidenceCurve = fitting_model_dict['confidence_curve']
        self.ConfidenceLevel = fitting_model_dict['confidence_level']
        self.FittedCurve = fitting_model_dict['fitted_curve']
        self.ForecastCurve = fitting_model_dict['forecast_curve']
        self.Frequency = fitting_model_dict['frequency']
        self.FrequencyExpression = fitting_model_dict['frequency_expression']
        self.Level = fitting_model_dict['level']
        self.Seasonal = fitting_model_dict['seasonal']
        self.SeasonalModelType = fitting_model_dict['seasonal_model_type']
        self.TimePointsAhead = fitting_model_dict['time_points_ahead']
        self.TimePointsAheadExpression = fitting_model_dict['time_points_ahead_expression']
        self.Trend = fitting_model_dict['trend']
        self.UseSeasonal = fitting_model_dict['use_seasonal']
        self.UseTrend = fitting_model_dict['use_trend']
        self.DataTableDetailItemsExpression = fitting_model_dict['data_table_detail_items_expression']
        self.DataTableEnabled = fitting_model_dict['data_table_enabled']
        self.DataTableReference = fitting_model_dict['data_table_ref']
        self.BeginExpression = fitting_model_dict['begin_expression']
        self.EndExpression = fitting_model_dict['end_expression']
        self.XColumnReference = fitting_model_dict['x_column_ref']
        self.YColumnReference = fitting_model_dict['y_column_ref']
        self.SortColumnReference = fitting_model_dict['sort_column_ref']
        self.BreakOnEmpty = fitting_model_dict['break_on_empty']
        self.AffectAxisRanges = fitting_model_dict['affect_axis_ranges']
        self.UseAxisTransform = fitting_model_dict['use_axis_transform']

        
class CurveLine:
    def __init__(self, curve_line_dict):
            self.Color = curve_line_dict['color']
            self.CustomDisplayName = curve_line_dict['custom_display_name']
            self.Details = curve_line_dict['details']
            self.Expression = curve_line_dict['expression']
            self.IsBackground = curve_line_dict['is_background']
            self.LineStyle = curve_line_dict['line_style']
            self.LineWidth = curve_line_dict['line_width']
            self.Visible = curve_line_dict['visible']
            
class FittingModelDetails:
    def __init__(self, Name, ShowInLabel, ShowInTooltip):
        self.Name = Name
        self.ShowInLabel = ShowInLabel
        self.ShowInTooltip = ShowInTooltip       

class InflectionPoint:
    def __init__(self, inflection_point_dict):
        self.AffectAxisRanges = inflection_point_dict['affect_axis_ranges']
        self.Color = inflection_point_dict['color']
        self.CustomDisplayName = inflection_point_dict['custom_display_name']
        self.IsBackground = inflection_point_dict['is_background']
        self.MarkerShape = inflection_point_dict['marker_shape']
        self.Size = inflection_point_dict['size']
        self.Visible = inflection_point_dict['visible']


class Markings:
    def __init__(self,name,color):
        self.name = name


class ColorAxis:
    def __init__(self,name,Expression,EvaluationMode,CategoryMode,AxisMode):
        self.name = name
        self.Expression = Expression
        self.EvaluationMode = EvaluationMode
        self.CategoryMode = CategoryMode
        self.AxisMode = AxisMode

        
class ComparativeAxis:
    def __init__(self,name,Expression,EvaluationMode,CategoryMode,AxisMode):
        self.name = name
        self.Expression = Expression
        self.EvaluationMode = EvaluationMode
        self.CategoryMode = CategoryMode
        self.AxisMode = AxisMode


class ShapeAxis:
    def __init__(self,name,Expression,EvaluationMode,CategoryMode,AxisMode,DefaultShape):
        self.name = name
        self.Expression = Expression
        self.EvaluationMode = EvaluationMode
        self.CategoryMode = CategoryMode
        self.AxisMode = AxisMode
        self.DefaultShape = DefaultShape


class CategoryAxis:
    def __init__(self,name,Expression,EvaluationMode,CategoryMode,AxisMode):
        self.name = name
        self.Expression = Expression
        self.EvaluationMode = EvaluationMode
        self.CategoryMode = CategoryMode
        self.AxisMode = AxisMode


class Legend:
    def __init__(self,dockPosition,Visible,Width,LegendItems):
        self.dockPosition = dockPosition
        self.Visible = Visible
        self.Width = Width
        self.LegendItems = LegendItems


class PieMarker:
    def __init__(self,params):
        self.SectorSizeAxis = params.get('sector_size_axis')
        self.LabelCategory = params.get('label_category')
        self.LabelPercentage = params.get('label_percentage')
        self.LabelPercentageDecimalDigits = params.get('label_percentage_decimal_digits')
        self.LabelPercentageLimit = params.get('label_percentage_limit')
        self.LabelPosition=params.get('label_position')
        self.LabelValue = params.get('label_value')
        self.LabelVisibility = params.get('label_visibility')

class LineConnection:
    def __init__(self,params):
        self.Color = params.get('color')
        self.ConnectionAxis = params.get('connection_axis')
        self.IsAttached = params.get('is_attached')
        self.IsBackground = params.get('is_background')
        self.OrderAxis = params.get('order_axis')
        self.ShowArrows = params.get('show_arrows')
        self.UseMarkerColor = params.get('use_marker_color')
        self.Width = params.get('width')

class Axis:
    def __init__(self,params):
        self.Name = params.get('axis_name')
        self.Expression = params.get('expression')
        self.Categorical = params.get('categorical')
        self.CategoryMode = params.get('category_mode')
        self.EvaluationMode = params.get('evaluation_mode')    
        self.IndividualScaling = params.get('individual_scaling')
        self.IndividualScalingMode = params.get('individual_scaling_mode')
        self.ScaleDock = params.get('scale_dock')
        self.ScaleFarSpan = params.get('scale_far_span')
        self.IncludeZeroInAutoZoom = params.get('include_zero_in_auto_zoom')
        self.IndexedIncludeZeroInAutoZoom = params.get('indexed_include_zero_in_auto_zoom')
        self.IndexedLeftScale = params.get('indexed_left_scale')
        self.IndexedRightScale = params.get('indexed_right_scale')
        self.IndexedLeftRangeHigh = params.get('indexed_left_range_high')
        self.IndexedLeftRangeLow = params.get('indexed_left_range_low')
        self.IndexedRightRangeHigh = params.get('indexed_right_range_high')
        self.IndexedRightRangeLow = params.get('indexed_right_range_low')
        self.IndexedDock = params.get('indexed_dock')
        self.IndexedLeftDock = params.get('indexed_left_dock')
        self.IndexedRightDock = params.get('indexed_right_dock')
        self.IndexedLabelOrientation = params.get('indexed_label_orientation')
        self.IndexedMaxNumTicks = params.get('indexed_max_num_ticks')
        self.IndexedLabelLayout = params.get('indexed_label_layout')
        self.IndexedShowLabels = params.get('indexed_show_labels')
        self.IndexedLeftShowLabels = params.get('indexed_left_show_labels')
        self.IndexedRightShowLabels = params.get('indexed_right_show_labels')
        self.IndexedShowGridlines = params.get('indexed_show_gridlines')
        self.IndexedLeftShowGridlines = params.get('indexed_left_show_gridlines')
        self.IndexedRightShowGridlines = params.get('indexed_right_show_gridlines')
        self.IndexedReversed = params.get('indexed_reversed')
        self.IndexedLeftReversed = params.get('indexed_left_reversed')
        self.IndexedRightReversed = params.get('indexed_right_reversed')
        self.IndexedTransformType = params.get('indexed_transform_type')
        self.IndexedLeftTransformType = params.get('indexed_left_transform_type')
        self.IndexedRightTransformType = params.get('indexed_right_transform_type')
        self.IndexedLeftLabelOrientation = params.get('indexed_left_label_orientation')
        self.IndexedRightLabelOrientation = params.get('indexed_right_label_orientation')
        self.IndexedLeftMaxNumTicks = params.get('indexed_left_max_num_ticks')
        self.IndexedRightMaxNumTicks = params.get('indexed_right_max_num_ticks')
        self.IndexedLeftLabelLayout = params.get('indexed_left_label_layout')
        self.IndexedRightLabelLayout = params.get('indexed_right_label_layout')
        self.ManualZoom = params.get('manual_zoom')
        self.RangeHigh = params.get('range_high')
        self.RangeLow = params.get('range_low')
        self.Reversed = params.get('reversed')
        self.LabelLayout = params.get('label_layout')
        self.LabelOrientation = params.get('label_orientation')
        self.MaxNumTicks = params.get('max_num_ticks')
        self.ShowGridlines = params.get('show_gridlines')
        self.ShowLabels = params.get('show_labels')
        self.ShowAxisSelector = params.get('show_axis_selector')
        self.TransformType = params.get('transform_type')
        self.ZoomRangeHigh = params.get('zoom_range_high')
        self.ZoomRangeLow = params.get('zoom_range_low')

class DocumentProperty:
    def __init__(self,name,value):
        self.name = name


class Table:
    def __init__(self, params):
        self.TableName = params.get('table_name')
        self.TableSource = params.get('table_source') 
        self.TableColumnOperations =params.get('table_column_operation')
        self.TableOperations = params.get('table_operations')
        self.TableTransformations = params.get('table_transformations')


class TableSource():
    def __init__(self,TableDataSource, TableConnection, InformationLinkDataSource, FileDataSource):
        self.TableConnection = TableConnection
        self.TableDataSource = TableDataSource
        self.InformationLinkDataSource = InformationLinkDataSource
        self.FileDataSource = FileDataSource


class FileDataSource:
    def __init__(self,type, sourceTableName, filePath,Separator):
        self.type = type
        self.sourceTableName = sourceTableName
        self.filePath = filePath
        self.Separator = Separator


class TableDataSource:
    def __init__(self,sourceTableName, updateBehavior,TableOperations):
        self.sourceTableName = sourceTableName
        self.updateBehavior = updateBehavior
        self.TableOperations = TableOperations

class InformationLinkDataSource:
    def __init__(self, guid,path):
        self.guid = guid
        self.path = path


class TableConnection:
    def __init__(self,connectionString,provider,Sql):
        self.connectionString = connectionString
        self.provider = provider
        self.Sql = Sql


class TableColumnOperations:  # Parent
    def __init__(self,CalculatedColumns,HierarchyColumns,BinnedColumns,FrozenColumns):
        self.CalculatedColumns = CalculatedColumns
        self.HierarchyColumns = HierarchyColumns
        self.BinnedColumns = BinnedColumns
        self.FrozenColumns = FrozenColumns


class CalculatedColumns:
    def __init__(self, columnName, columnExpression):
        self.columnName = columnName
        self.columnExpression= columnExpression


class HierarchyColumns:
    def __init__(self, Name ,nestingMode, hierarchyExpressions):
        self.HierarchyName = Name
        self.nestingMode = nestingMode
        self.hierarchyExpressions = hierarchyExpressions


class BinnedColumns:
    def __init__(self, Name , Expression):
        self.BinnedColName = Name
        self.Expression = Expression


class FrozenColumns:
    def __init__(self, Name):
        self.FrozenColName = Name


class MeasureManager:
    def __init__(self, nodeName, collectionName,SystemArea, NodeType, objAggregation, TimePeriod, startTime,StopTime, TimeAggregation,weekdayFilter, selectedKPIs):
        self.columnName = columnName
        self.columnExpression= columnExpression


class TableOperations:
    def __init__(self, AddColumnOperation, AddRowOperation, RemoveColumnOperation,RemoveRowOperation):
        self.AddColumnOperation = AddColumnOperation
        self.AddRowOperation = AddRowOperation
        self.RemoveColumnOperation =RemoveColumnOperation
        self.RemoveRowOperation =RemoveRowOperation


class AddColumnOperation:
    def __init__(self, params):
        self.TreatEmptyValuesAsEqual = params.get('treat_empty_values_as_equal')
        self.DataLoadingBehavior = params.get('data_loading_behavior')
        self.joinTypeSetting = params.get('join_type')
        self.ignoredColSetting = params.get('ignored_columns')
        self.mapSetting = params.get('col_map')


class AddRowOperation:
    def __init__(self, params):
        self.CreateNewSourceColumn = params.get('create_new_source_column')
        self.NewRowSourceValue = params.get('new_row_source_value')
        self.OriginalRowSourceValue = params.get('original_row_source_value')
        self.RowSourceColumnName = params.get('row_source_column_name')
        self.UseExistingSourceColumn = params.get('use_existing_source_column')
        self.ignoredColSetting = params.get('ignored_columns')
        self.mapSetting = params.get('col_map')


class RemoveColumnOperation:
    def __init__(self, originalTable, addedTable):
        self.originalTable = originalTable
        self.addedTable = addedTable


class RemoveRowOperation:
    def __init__(self, originalTable, addedTable):
        self.originalTable = originalTable
        self.addedTable = addedTable


class TableTransformations:
    def __init__(self, params):
        self.PivotTransformation = params.get('pivot_list')
        self.UnpivotTransformation = params.get('unpivot_list')
        self.ChangeColumnTransformation = params.get('change_col_list')
        self.ChangeColumnNameTransformation = params.get('change_col_name_list')
        self.ExcludeColumnTransformation = params.get('exclude_col_list')
        self.ReplaceSpecificValueTransformation = params.get('replace_spec_val_list')
        self.FilterRowsTransformation = params.get('filter_rows_list')


class PivotTransformation:
    def __init__(self, params):
        self.CategorySeparator = params.get('category_separator')
        self.ResultNamingExpression = params.get('result_name_expression')
        self.TransferNamingExpression = params.get('transfer_naming_expression')
        self.CategoryColumnList = params.get('pivot_col_list')
        self.IdentityColumnList = params.get('id_col_list')
        self.TransferColumnsDict = params.get('transfer_col_dict')
        self.ValueColumnsDict = params.get('val_col_dict')


class UnpivotTransformation:
    def __init__(self, params):
        self.categoryName = params.get('category_name')
        self.categoryType = params.get('category_type')
        self.resultName = params.get('result_name')
        self.resultType = params.get('result_type')
        self.IdentityColumnList = params.get('id_col_list')
        self.ValueColumnsList = params.get('val_col_list')


class ChangeColumnTransformation:
    def __init__(self,name, columnList,columnNameExpression,expression):
        self.name = name 
        self.columnList = columnList 
        self.columnNameExpression = columnNameExpression
        self.expression = expression


class ChangeColumnNameTransformation:
    def __init__(self,renameColList,columnNameExpression):
        self.renameColList = renameColList 
        self.columnNameExpression = columnNameExpression


class ExcludeColumnTransformation:
    def __init__(self,excludeColList):
        self.excludeColList = excludeColList 


class ReplaceSpecificValueTransformation:
    def __init__(self,params):
        self.columnName = params.get('category_name') 
        self.originalValue = params.get('original_value')
        self.newValue = params.get('new_value')
        self.rowIdentifyingCols = params.get('row_identifying_cols')
        self.rowIdentifyingColVals = params.get('row_identifying_col_vals')
        self.warnWhenReplacingMultipleValues = params.get('warn_when_replacing_mult_vals')

class ReplaceValueTransformation:
    def __init__(self,replaceColList, resultColumnName):
        self.replaceColList = replaceColList 
        self.resultColumnName = resultColumnName


class FilterRowsTransformation:
    def __init__(self,filterCondition):
        self.filterCondition = filterCondition


class DataEncoder(JSONEncoder):
    def default(self, o):
        return o.__dict__


def get_data_filters(vis):
    """
    Gets the data filter attributes from the visualization

    Arguments:
        vis {Object} -- visualization object

    Returns:
        DataFilters {conts} -- calls DataFilters constructor
    """
    tbl_data_limit_list = []
    limit_message = ''
    tbl_marking_list = []
    tbl_filtering_scheme_list = []

    visualization = vis.As[Visualization]()

    for filtering in vis.As[VisualContent]().Data.Filterings:
        if Document.Data.Markings.Contains(filtering.Name):
            tbl_marking_list.append(Markings(Document.Data.Markings[filtering.Name].Name,Document.Data.Markings[filtering.Name].Color.ToArgb()))
        else:
            tbl_filtering_scheme_list.append(FilteringScheme(filtering.Name))

        if(visualization.Data.LimitingMarkingsEmptyBehavior == LimitingMarkingsEmptyBehavior.ShowMessage):
            limit_message = visualization.Data.LimitingMarkingsEmptyMessage

    tbl_data_limit_list.append(DataLimiting(str(visualization.Data.MarkingCombinationMethod),tbl_marking_list,tbl_filtering_scheme_list,visualization.Data.WhereClauseExpression,str(visualization.Data.LimitingMarkingsEmptyBehavior),limit_message))

    tbl_marking_list = []
    if visualization.Data.MarkingReference is not None:
        tbl_marking_list.append(Markings(visualization.Data.MarkingReference.Name,visualization.Data.MarkingReference.Color.ToArgb()))

    return DataFilters(tbl_marking_list,tbl_data_limit_list,tbl_filtering_scheme_list)


def save_data_table_to_custom_library(data_table_name,json_template):
    """
    Writes JSON data of the report to SF data table and saves data table to the custom library
    Arguments:
        data_table_name {string} -- data table name that will be used to create temporary SF dt to place JSON data
        json_template {string} -- JSON data of the report that requires to be saved
    """

    stream = MemoryStream()
    csvWriter = StreamWriter(stream)
    csvWriter.Flush()

    settings = TextDataReaderSettings()
    settings.AddColumnNameRow(0)
    settings.ClearDataTypes(False)
    settings.SetDataType(0, DataType.String)
    stream.Seek(0, SeekOrigin.Begin)
    fs = TextFileDataSource(stream, settings)
    if Document.Data.Tables.Contains(data_table_name):
        Document.Data.Tables[data_table_name].ReplaceData(fs)
    else:
        Document.Data.Tables.Add(data_table_name, fs) 
    json_template = json_template.replace('\r', '').replace('\n', '')
    text_data = "JSON###\r\n" + json_template

    stream = MemoryStream()
    writer = StreamWriter(stream)
    writer.Write(text_data)
    writer.Flush()
    stream.Seek(0, SeekOrigin.Begin)

    reader_settings = TextDataReaderSettings()
    reader_settings.Separator = "###"
    reader_settings.AddColumnNameRow(0)
    reader_settings.SetDataType(0, DataType.String)
    text_data_source = TextFileDataSource(stream,reader_settings)

    settings = AddRowsSettings(Document.Data.Tables[data_table_name],text_data_source)

    Document.Data.Tables[data_table_name].AddRows(text_data_source,settings)

    folder = '/Custom Library/PMEX Reports/'

    data_table = Document.Data.Tables[data_table_name]
    file_name = data_table_name
    full_path = str(folder + file_name)

    lm = Application.GetService(LibraryManager)
    (found_file, file_item) = lm.TryGetItem(full_path, LibraryItemType.SbdfDataFile, LibraryItemRetrievalOption.IncludeProperties)
    (found_folder, folder_item) = lm.TryGetItem(folder, LibraryItemType.Folder, LibraryItemRetrievalOption.IncludeProperties)

    try:
        if found_file:
            data_table.ExportDataToLibrary(file_item, file_name)
        elif found_folder:
            data_table.ExportDataToLibrary(folder_item, file_name)
        returnFlag = True
    except Exception as e:
        Document.Properties["saveReportErrorMsg"] = "To Save a report, Verify the Permission - Custom Library/PMEX Reports"
        notify.AddWarningNotification("Exception","Path not found. Please review settings",str(e))
        print("Exception: ", e)
        returnFlag = False

    Document.Data.Tables.Remove(data_table)
    return returnFlag


def _from_bytes(bts):
    return [ord(b) for b in bts]


def _from_hex_digest(digest):
    return [int(digest[x:x+2], 16) for x in xrange(0, len(digest), 2)]


def decrypt(data, digest=True):
    '''
    Performs decrypting of provided encrypted data. 
    If 'digest' is True data must be hex digest, otherwise data should be
    encrtypted bytes.
    
    This function is symetrical with encrypt function.
    '''

    try:
        data = Array[Byte](map(Byte, _from_hex_digest(data) if digest else _from_bytes(data)))
        
        rm = RijndaelManaged()
        dec_transform = rm.CreateDecryptor(_key, _vector)
    
        mem = MemoryStream()
        cs = CryptoStream(mem, dec_transform, CryptoStreamMode.Write)
        cs.Write(data, 0, data.Length)
        cs.FlushFinalBlock()
        
        mem.Position = 0
        decrypted = Array.CreateInstance(Byte, mem.Length)
        mem.Read(decrypted, 0, decrypted.Length)
        
        cs.Close()
        utf_encoder = UTF8Encoding()
        return utf_encoder.GetString(decrypted)

    except Exception as e:
        notify.AddWarningNotification("Exception","Error in DataBase Connection",str(e))
        print("Exception: ", e)


def get_list_of_tables_in_current_analysis(report_name):
    '''
    Get the list of the SF dt that were created after data fetched for selected measures

    Returns:
        table_list {list} -- generated tables list
    '''

    table_list= []   
    for tbl in Document.Data.Tables:
        if tbl.Name not in pmex_table_list and not tbl.Name.startswith('DC_') and not tbl.Name.startswith('DIM_'):
            if tbl.Name.startswith('pm_') or tbl.Name.startswith(report_name) or tbl.Name.startswith(selected_report):
                if ':' in tbl.Name:
                    if not tbl.Name.split(':')[1].startswith('DC_'):
                        table_list.append(tbl.Name.split(':')[1])
                else:
                    table_list.append(tbl.Name)
            
    return table_list

def get_list_of_graphs_in_current_analysis(): 
    '''
    Get the list of the SF graphs(visualizations) that were created within analysis

    Returns:
        vis_list {list} -- generated graphs(visualizations) list
    '''

    vis_list = []
    for p in Document.Pages:
        for v in p.Visuals:
            if v.Title != "" :
                if str(v.TypeId) !=  "TypeIdentifier:Spotfire.HtmlTextArea" and str(v.TypeId) !=  "TypeIdentifier:Spotfire.Table":
                    vis_list.append(str(v.Title) + '_' + str(v.TypeId).split(':Spotfire.')[1])

    return vis_list


def check_empty(*args):
    '''
    Checks if arguments passed are blank or not

    Returns:
        response {list} -- boolean response list
    '''
    response = []
    if len(args) != 0:
        for item in args:
            if item == "":
                response.append(True)
            else:
                response.append(False)
    return response


def create_cursor(e_table):
    """
    Create cursors for a given table, these are used to loop through columns

    Arguments:
        e_table {data table object} -- data table object to get cursors

    Returns:
        curs_dict {dict} -- dictionary of cursors list
    """
    curs_list = []
    col_list = []
    for e_column in e_table.Columns:
        curs_list.append(DataValueCursor.CreateFormatted(e_table.Columns[e_column.Name]))
        col_list.append(e_table.Columns[e_column.Name].ToString())
    curs_dict = dict(zip(col_list, curs_list))
    return curs_dict


def get_distinct_values_list(data_table, cursor, specified_column):
    """
    Creates distincted(unique) values list for data table for specified column

    Arguments:
        data_table {data table object} -- data table object to get distincted values
        cursor {dict} -- cursors dictionary for the data table
        specified_column {String} -- column name of the data table

    Returns:
        list_values {list} -- list of distincted(unique) values of the column
    """
    list_values = []
    rows = IndexSet(data_table.RowCount, True)
    for row in data_table.GetDistinctRows(rows,cursor[specified_column]):
            list_values.append(cursor[specified_column].CurrentValue)
    return list_values

def selectedCreatedByToModify(reportName):
    dataTable = Document.Data.Tables["tblSavedReports"]
    CreatedByCursor = DataValueCursor.CreateFormatted(dataTable.Columns["CreatedBy"])
    CreatedOnCursor = DataValueCursor.CreateFormatted(dataTable.Columns["CreatedOn"])
    query   = "[ReportName] = '{0}'".format(reportName)
    indexFilter = dataTable.Select(query)
    
    for row in dataTable.GetRows(indexFilter.AsIndexSet(), CreatedByCursor, CreatedOnCursor):
        #rowIndex = row.Index ##un-comment if you want to fetch the row index into some defined condition
        value1 = CreatedByCursor.CurrentValue
        CreatedOn = CreatedOnCursor.CurrentValue
        if value1 <> str.Empty:
            return value1, CreatedOn

def generate_report_sql(sql_parameters_dict):
    """
    Creates sql statement template for the report with required attributes.

    Arguments:
        sql_parameters_dict {dict} -- dictionary of parameters required to create sql statement template
      
    Returns:
        sql {String} -- sql statement template
    """
    sql = ''
    if "PostgreSQL" in sql_parameters_dict['conn_string']:
        sql = """
            INSERT INTO "tblSavedReports" ("ReportName","ReportDescription", "ReportAccess","ReportTableList", "ReportGraphList", "CreatedBy", "CreatedOn", "ENIQName", "CollectionID", "MeasureName", "MeasureType", "ModifiedBy", "LastModifiedOn")
                VALUES (
                    '{report_name}',
                    '{report_description}',
                    '{report_access_type}',
                    '{table_list}',
                    '{graph_list}',
                    '{created_by}',
                    '{CreatedOn}',
                    '{eniqName}',
                    '{CollectionID}',
                    '{MeasureName}',
                    '{MeasureType}',
                    '{modified_by}',
                    '{LastModifiedOn}'
                );
            """.format(**sql_parameters_dict)
    else:
        sql = """
            INSERT INTO tblSavedReports (ReportName, ReportDescription, ReportAccess, ReportTableList, ReportGraphList,CreatedBy, LastModified, ENIQName, CollectionID, MeasureName, MeasureType,ModifiedBy)
                VALUES (
                    '{report_name}',
                    '{report_description}',
                    '{report_access_type}',
                    '{table_list}',
                    '{graph_list}',
                    '{created_by}',
                    '{LastModified}',
                    '{eniqName}',
                    '{CollectionID}',
                    '{MeasureName}',
                    '{MeasureType}',
                    '{modified_by}'
                    
                )
            """.format(**sql_parameters_dict)
    print(sql)
    return sql


def write_delete_from_db(sql):
    """
    Executes sql query in NetAn db to insert/delete reports

    Arguments:
        sql {String} -- sql statement template
        
    Returns:
        {boolean} -- true or false based on if sql staetement executed successfully or not
    """
    conn_string = Document.Properties['ConnStringNetAnDB'].replace("@NetAnPassword", decrypt(Document.Properties['NetAnPassword']))

    try:
        connection = OdbcConnection(conn_string)
        connection.Open()
        command = connection.CreateCommand()
        command.CommandText = sql
        command.ExecuteReader()
        connection.Close()
        return True
    except Exception as e:
        print (e.message)
        return False


def delete_from_custom_library(report_name):
    """
    Removes selected analysis from custom library

    Arguments:
        report_name {String} -- name of the report that already exists in custom library and needs to be deleted
        
    """
    lm = Application.GetService(LibraryManager)
    (found, item) = lm.TryGetItem('/Custom Library/PMEX Reports/pm_'+report_name+'_JSON', LibraryItemType.SbdfDataFile, LibraryItemRetrievalOption.IncludeProperties)
    guid = ''
    if found:
        guid = item.Id
    else:
        my_guid = Guid(str(guid))
        (found, item) = lm.TryGetItem(my_guid)
    if found:
        try:
            lm.Delete(item)
            return True
        except Exception as e:
            notify.AddWarningNotification("Exception","Path not found. Please review settings",str(e))
            print("Exception: ", e) 
            return False


def nav_to_report_manager():
    '''
    Navigates to report manager page
    '''
    for page in Document.Pages:
        if (page.Title == 'Report Manager'):
            Document.ActivePageReference=page


def nav_to_report_measures_page():
    '''
    Navigates to Measures Selections page
    '''
    for page in Document.Pages:
        if (page.Title == 'Report:Measure Selections'):
            Document.ActivePageReference=page


def validate_inputs():
    '''
    Checks if inputs are not blank or tables and graphs created for the report
    '''
    if check_empty(Document.Properties['ReportName'])[0] == True:
        Document.Properties['saveReportErrorMsg'] = '*Report name cannot be blank'
        return False
    if check_empty(Document.Properties['ReportDescription'])[0] == True:
        Document.Properties['saveReportErrorMsg'] = '*Description cannot be blank'
        return False
    if len(report_table_list) == 0:
        Document.Properties['saveReportErrorMsg'] = '*Add tables and graphs to create report'
        return False

    return True
    
    
def save_report(report_json_file_name, saved_reports_table, created_by, modified_by, CreatedOn, LastModified):
    """
    Places report variables in the dictionary and calls other functions to save report data to NetAn db and to custom library

    Arguments:
        report_json_file_name {String} -- name of the JSON file (DT) that will be saved in the custom library
        saved_reports_table {data table} -- data table with all saved reports
        
    """
    
    collectionIDs, MeasureList, MeasureType, returnFlag = serialize_report_meta_data(report_json_file_name,report_name)  #Invoke serialization from here.
    
    conn_string = Document.Properties["ConnStringNetAnDB"]
    sql_parameters_dict = {
    'report_name':report_name,
    'report_description':report_description,
    'report_access_type':report_access_type,
    'table_list':(','.join([str(tbl) for tbl in report_table_list])),
    'graph_list':(','.join([str(graph) for graph in report_graph_list])),
    'MeasureName': (','.join([str(msrName) for msrName in MeasureList])), 
    'MeasureType': (','.join([str(msrType) for msrType in MeasureType])),
    'created_by': created_by,
    'CreatedOn': CreatedOn,
    'LastModifiedOn': LastModified,
    'modified_by': modified_by,
    'eniqName': (','.join({str(tblnm).split("__")[-1] for tblnm in report_table_list})),
    'CollectionID': (','.join([str(colID) for colID in collectionIDs])) if collectionIDs else "",
    'conn_string':conn_string,
    }
    sql = generate_report_sql(sql_parameters_dict)
    
    if returnFlag and (write_delete_from_db(sql)): 
        #serialize_report_meta_data(report_json_file_name,report_name)  #Invoke serialization from here.
        nav_to_report_manager()
                
        saved_reports_table.Refresh()
        clean_up(report_name)

def selectedReportToModify():
    dataTable = Document.Data.Tables["tblSavedReports"]
    cursor = DataValueCursor.CreateFormatted(dataTable.Columns["ReportName"])
    cursor1 = DataValueCursor.CreateFormatted(dataTable.Columns["ReportName"])
    markings = Document.Data.Markings['ReportSelectionMarking'].GetSelection(dataTable)
    #markings = Document.ActiveMarkingSelectionReference.GetSelection(dataTable)

    if markings.IncludedRowCount != 1:
        Document.Properties["saveReportErrorMsg"] = "To Edit a Collection, select one collection"
        return None    
    else:
        Document.Properties["saveReportErrorMsg"] = ""    
        markedata = List [str]();
        for row in dataTable.GetRows(markings.AsIndexSet(),cursor):
            #rowIndex = row.Index ##un-comment if you want to fetch the row index into some defined condition
            value1 = cursor.CurrentValue
            if value1 <> str.Empty:
                markedata.Add(value1)
                return markedata[0]

def get_report_details(report_name, report_description, report_access_type):
    """
    Gets report variables and calls other functions to save report data to NetAn db and to custom library

    Arguments:
        report_name {String} -- name of the report
        report_description {String} -- description of the report
        report_access_type {String} -- access level of the report
        
    """

    return_flag = False

    file_extension = '_JSON'
    report_json_file_name = report_name+file_extension

    saved_reports_table = Document.Data.Tables['tblSavedReports']
    saved_reports_table_cursor = create_cursor(saved_reports_table)

    new_report_name =report_name 
    report_name_exists  = Document.Properties["ReportNameExists"]
    
    if Document.Properties["Mode"] == 'Edit':
        ReportName_old  = selectedReportToModify()
        createdBy, CreatedOn = selectedCreatedByToModify(ReportName_old)
        modified_by     = user_name
        LastModified = str(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
    else:
        ReportName_old  = new_report_name
        createdBy       = user_name
        CreatedOn       =  str(datetime.date.today())
        modified_by     = ""
        LastModified    = str(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))

    if validate_inputs():
        if report_name_exists:
            deletedFlag = delete_from_custom_library(new_report_name)
            if deletedFlag:
                sql = 'Delete from "tblSavedReports" where "ReportName"='+"'"+report_name+"'"
                write_delete_from_db(sql)
                saved_reports_table.Refresh()
                save_report(report_json_file_name, saved_reports_table, createdBy, modified_by, CreatedOn, LastModified)
        elif Document.Properties["Mode"] == 'Edit' and report_name_exists == False:
            deletedFlag = delete_from_custom_library(ReportName_old)
            if deletedFlag:
                sql = 'Delete from "tblSavedReports" where "ReportName"='+"'"+ReportName_old+"'"
                write_delete_from_db(sql)
                saved_reports_table.Refresh()
                save_report(report_json_file_name, saved_reports_table, createdBy, modified_by, CreatedOn, LastModified)
        else:
            save_report(report_json_file_name, saved_reports_table, createdBy, modified_by, CreatedOn, LastModified)

def get_sql_comment_part(query):
    '''Extracts comment part of the SQL
    Arguments:
        query {String} -- SQL query
    Returns:
        extracted_comment_string {String} -- comment part extracted from the SQL
    ''' 
    start = query.find("/*") + len("/*")
    end = query.find("*/")
    comment_string = query[start:end]
    extracted_comment_string =  str(comment_string).replace("'", '"')

    return extracted_comment_string
    
def findCollectionInReports(json_object):
    """ to find out report consist / of  collections , 
        Arguments:
        json_object {String} -- json_object is a json_template
    """
    json_object = json.loads(json_object) 
    collectionIDs   = set()
    MeasureList     = set()
    MeasureType     = set()
    for tablelist in json_object['TableList']:
        tableConnection = tablelist['TableSource']['TableConnection']
        if tableConnection:
            for tableSql in tableConnection:
                rawSql = tableSql['Sql']
                extracted_comment_string = get_sql_comment_part(rawSql)
                measures_dict = json.loads(extracted_comment_string)
                if measures_dict['CollectionName']: 
                   Collectionnames = measures_dict['CollectionName']
                   print(Collectionnames,type(Collectionnames))
                   collectionTempIDs = GetCollectionID(Collectionnames)
                   collectionIDs.update(collectionTempIDs)
                MeasureList.update(measures_dict['MeasureList'])
                MeasureType.add(measures_dict['MeasureType'])
    return  collectionIDs, MeasureList, MeasureType        

def GetCollectionID(collectionNames):
    """
    somethingh
    """
    nodeCollectionTable = Document.Data.Tables['NodeCollection']
    nodeColCursor = create_cursor(nodeCollectionTable)
    query = ' OR '.join("[CollectionName]='{0}'".format(c ) for c in collectionNames)
    print(query)
    indexFilter = nodeCollectionTable.Select(query)
    indexSet = indexFilter.AsIndexSet()
    
    collectionSet = set()
    for collectionRow in nodeCollectionTable.GetRows(indexSet, Array[DataValueCursor](nodeColCursor.values())):
        #collectionSet[nodeColCursor['CollectionName'].CurrentValue] = nodeColCursor['CollectionID'].CurrentValue
        collectionSet.add(nodeColCursor['CollectionID'].CurrentValue)
    return collectionSet
    


def serialize_report_meta_data(report_json_file_name,report_name):
    """
    Gets report name, graph and table objects and stores them in JSON format as JSON template

    Arguments:
        report_json_file_name {String} -- name of the JSON file
        report_name {String} -- name of the report
        
    """
    page_list = get_page_objects()
    tbl_obj_list = build_table_object_list()
    
    rep_list = Report(report_name, ReportMetaData(report_description,report_access_type), page_list,tbl_obj_list)
      
    json_template = (rep_list.toJSON())
    #print json_template
    
    collectionIDs, MeasureList, MeasureType = findCollectionInReports(json_template)

    returnFlag = save_data_table_to_custom_library('pm_'+report_json_file_name,json_template)
    return collectionIDs, MeasureList, MeasureType, returnFlag


def get_legend_obj(vis):
    """
    Gets legend class properties and builds legend object

    Arguments:
        vis {object} -- visualization object

    Returns:
        Legend {object} -- legend object
        
    """

    if vis.Legend.Dock == LegendDock.Right:
        doc_post  = 'Right'
    else:
        doc_post  = 'Left'

    legend_items_dict = {}
    for i in vis.Legend.Items:
        if i.Title == "Title":
            legend_items_dict[i.Title] = {'Visible':i.Visible}
        elif i.Title == "Description":
            legend_items_dict[i.Title] = {'Visible':i.Visible}
        elif i.Title == "Data limiting":
            legend_items_dict[i.Title] = {'Visible':i.Visible}
        elif i.Title == "Data table":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}
        elif i.Title == "Marking":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}
        elif i.Title == "Show/hide":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}
        elif i.Title == "Trellis by":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}
        elif i.Title == "Color by":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle, 'ShowAxisSelector':i.ShowAxisSelector}
        elif i.Title == "Shape by":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle, 'ShowAxisSelector':i.ShowAxisSelector}
        elif i.Title == "Size by":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle, 'ShowAxisSelector':i.ShowAxisSelector}
        elif i.Title == "Rotation by":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle, 'ShowAxisSelector':i.ShowAxisSelector}
        elif i.Title == "Sector size by":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle, 'ShowAxisSelector':i.ShowAxisSelector}
        elif i.Title == "Row limit":
            legend_items_dict[i.Title] = {'Visible':i.Visible}
        elif i.Title == "Colors":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}
        elif i.Title == "Line connection":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}
        elif i.Title == "Lines and curves":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}
        elif i.Title == "Error bars":
            legend_items_dict[i.Title] = {'Visible':i.Visible, 'ShowTitle':i.ShowTitle}

    return Legend(doc_post,vis.Legend.Visible, vis.Legend.Width,legend_items_dict)


def get_graph_objects_attributes(chart, page, chart_graph_flag, vis):
    """
    Gets all available graph objects attributes and stores them in class object

    Arguments:
        chart {object} -- chart object
        page {object} -- page object
        chart_graph_flag {String} -- flag to identify graph type

    Returns:
        graph_obj {object} -- class object based on graph type
        
    """
    chart_title = chart.Title

    page_title = ''

    legend_obj = get_legend_obj(vis.As[Visualization]())
    
    if (chart.Data.DataTableReference is not None):  
        table_ref_name = chart.Data.DataTableReference.Name
        if table_ref_name not in report_table_list_json and table_ref_name not in pmex_table_list:
            report_table_list_json.append(table_ref_name)
            if '_PDF' in table_ref_name:
               if '_Source' not in table_ref_name:
                   report_table_list_json.append(table_ref_name + '_Source')

    page_title = get_name_in_report(page.Title)
    
    if ':' in table_ref_name: #handling edit scenario
        table_ref_name = table_ref_name.split(':')[1]
    
    if chart_graph_flag == 'TablePlot':
        vis_obj_dict={
        'chart_title':chart_title,
        'show_title':bool(chart.Visual.ShowTitle),
        'description':chart.Description,
        'show_description':chart.ShowDescription,
        'table_name':table_ref_name,
        'data_filters':get_data_filters(vis),
        'legend_obj':legend_obj,
        'header_height':chart.HeaderHeight,
        'row_height':chart.RowHeight,
        'frozen_count':chart.FrozenCount,
        'cell_border_style':int(chart.CellBorderStyle),
        'export_data_enabled':bool(chart.ExportDataEnabled),
        'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
        'show_hide_items':get_show_hide_items(chart)
        }
        graph_obj = TablePlotMetaData(vis_obj_dict)
        return graph_obj

    non_common_charts = ["CrossTable", "PieChart", "ScatterPlot", "HeatMap", "CombinationChart", "BoxPlot", "SummaryTable", "TreeMap", "KpiChart"]

    if chart_graph_flag not in non_common_charts:
        fitting_models = get_fitting_models(chart)
        color_axis_obj =ColorAxis(chart.ColorAxis.Name,chart.ColorAxis.Expression,int(chart.ColorAxis.EvaluationMode),int(chart.ColorAxis.CategoryMode),int(chart.ColorAxis.AxisMode))
        trellis_obj = Trellis(str(chart.Trellis.TrellisMode), chart.Trellis.ManualColumnCount, chart.Trellis.ManualLayout,chart.Trellis.ManualRowCount,chart.Trellis.PanelAxis.Expression,chart.Trellis.PageAxis.Expression, chart.Trellis.RowAxis.Expression,chart.Trellis.ColumnAxis.Expression, str(chart.Trellis.ColumnAxis.AxisMode),str(chart.Trellis.ColumnAxis.CategoryMode),str(chart.Trellis.ColumnAxis.EvaluationMode),str(chart.Trellis.PageAxis.AxisMode),str(chart.Trellis.PageAxis.CategoryMode),str(chart.Trellis.PageAxis.EvaluationMode),str(chart.Trellis.RowAxis.AxisMode),str(chart.Trellis.RowAxis.CategoryMode),str(chart.Trellis.RowAxis.EvaluationMode),str(chart.Trellis.PanelAxis.AxisMode),str(chart.Trellis.PanelAxis.CategoryMode),str(chart.Trellis.PanelAxis.EvaluationMode))
        vis_obj_dict={
                'page_name':page_title,
                'chart_title':chart_title,
                'show_title':bool(chart.Visual.ShowTitle),
                'table_name':table_ref_name,
                'x_axis':chart.XAxis.Expression,
                'y_axis':chart.YAxis.Expression,
                'transparency':float(chart.Transparency),
                'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
                'compensate_for_missing_time_series_values':bool(chart.CompensateForMissingTimeSeriesValues),
                'trellis':trellis_obj,
                'color_axis':color_axis_obj,
                'fitting_models':fitting_models,
                'data_filters':get_data_filters(vis)
        }
        
    if chart_graph_flag == 'BarChart':
        x_axis_dict = get_x_axis_properties(chart)
        x_axis_obj = Axis(x_axis_dict)
        y_axis_dict = get_y_axis_properties(chart,chart_graph_flag)
        y_axis_obj = Axis(y_axis_dict)

        vis_obj_dict['description']=chart.Description
        vis_obj_dict['show_description']=chart.ShowDescription
        vis_obj_dict['layout']=int(chart.StackMode)
        vis_obj_dict['label_visibility']=int(chart.LabelVisibility)
        vis_obj_dict['label_orientation']=int(chart.LabelOrientation)
        vis_obj_dict['label_complete_bar']=bool(chart.LabelCompleteBar)
        vis_obj_dict['label_segments']=bool(chart.LabelSegments)
        vis_obj_dict['segment_label_information_type']=int(chart.SegmentLabelInformationType)
        vis_obj_dict['max_number_of_labels']=int(chart.MaxNumberOfLabels)
        vis_obj_dict['label_percentage_decimal_digits']=int(chart.LabelPercentageDecimalDigits)
        vis_obj_dict['legend_obj']=legend_obj
        vis_obj_dict['x_axis']=x_axis_obj
        vis_obj_dict['y_axis']=y_axis_obj
        vis_obj_dict['show_hide_items']=get_show_hide_items(chart)
        vis_obj_dict['bar_width']=int(chart.BarWidth) 
        vis_obj_dict['show_shadow_bars']=bool(chart.ShowShadowBars)
        vis_obj_dict['sorted_bars']=bool(chart.SortedBars)
        vis_obj_dict['sort_segments_by_size']=bool(chart.SortSegmentsBySize)
        vis_obj_dict['reverse_segment_order']=bool(chart.ReverseSegmentOrder)
        vis_obj_dict['orientation']=int(chart.Orientation)
   
        graph_obj = BarGraphMetaData(vis_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'LineGraph':
        x_axis_dict = get_x_axis_properties(chart)
        x_axis_obj = Axis(x_axis_dict)
        y_axis_dict = get_y_axis_properties(chart,chart_graph_flag)
        y_axis_obj = Axis(y_axis_dict)

        vis_obj_dict['line_width']=int(chart.LineWidth)
        vis_obj_dict['break_on_empty']=bool(chart.BreakOnEmpty)
        vis_obj_dict['line_by_axis_expression']=chart.LineByAxis.Expression
        vis_obj_dict['show_markers']=bool(chart.ShowMarkers)
        vis_obj_dict['stepped_lines']=bool(chart.SteppedLines)
        vis_obj_dict['marker_size']=float(chart.MarkerSize)
        vis_obj_dict['description']=str(chart.Description)
        vis_obj_dict['max_number_of_labels']=int(chart.MaxNumberOfLabels)
        vis_obj_dict['show_description']=bool(chart.ShowDescription)
        vis_obj_dict['show_individual_scaling']=bool(chart.ShowIndividualScaling)
        vis_obj_dict['show_line_labels']=bool(chart.ShowLineLabels)
        vis_obj_dict['show_marker_labels']=bool(chart.ShowMarkerLabels)
        vis_obj_dict['legend_obj']=legend_obj
        vis_obj_dict['label_visibility']=int(chart.LabelVisibility)
        vis_obj_dict['show_hide_items']=get_show_hide_items(chart)
        vis_obj_dict['x_axis']=x_axis_obj
        vis_obj_dict['y_axis']=y_axis_obj
            
        graph_obj = LineGraphMetaData(vis_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'CrossTable':
        cross_table_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'table_name':table_ref_name,
            'col_axis':chart.ColumnAxis.Expression,
            'col_axis_mode':str(chart.ColumnAxis.AxisMode),
            'col_axis_name':str(chart.ColumnAxis.Name),
            'col_axis_evaluation_mode':str(chart.ColumnAxis.EvaluationMode),
            'col_sub_totals_layout':str(chart.ColumnSubtotalsLayout),
            'empty_cell_text':chart.EmptyCellText,
            'export_enabled':chart.ExportDataEnabled,
            'indicate_hidden_cols':chart.IndicateHiddenColumns,
            'indicate_hidden_rows':chart.IndicateHiddenRows,
            'legend':legend_obj,
            'measure_axis':chart.MeasureAxis.Expression,
            'measure_axis_name':chart.MeasureAxis.Name,
            'row_axis':chart.RowAxis.Expression,
            'row_axis_name':chart.RowAxis.Name,
            'show_axis_selectors':chart.ShowAxisSelectors,
            'show_col_grand_total':chart.ShowColumnGrandTotal,
            'show_cont_color':chart.ShowContinuousColor,
            'show_gridlines':chart.ShowGridlines,
            'show_row_grand_total':chart.ShowRowGrandTotal,
            'show_top_n_cols':chart.ShowTopNColumns,
            'show_top_n_rows':chart.ShowTopNRows,
            'sort_cols_cat':str(chart.SortColumnsCategory),
            'sort_cols_order':str(chart.SortColumnsOrder),
            'sort_rows_cat':str(chart.SortRowsCategory),
            'sort_rows_mode':str(chart.SortRowsMode),
            'sort_rows_order':str(chart.SortRowsOrder),
            'supports_transparency':chart.SupportsTransparency,
            'transparency':chart.Transparency,
            'top_n_col_count':chart.TopNColumnCount,
            'top_n_row_count':chart.TopNRowCount,
            'data_filters':get_data_filters(vis),
            'show_hide_items':get_show_hide_items(chart)
        }
        graph_obj = CrossTableMetaData(cross_table_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'PieChart':
        
        color_axis_obj =ColorAxis(chart.ColorAxis.Name,chart.ColorAxis.Expression,int(chart.ColorAxis.EvaluationMode),int(chart.ColorAxis.CategoryMode),int(chart.ColorAxis.AxisMode))
        trellis_obj = Trellis(str(chart.Trellis.TrellisMode), chart.Trellis.ManualColumnCount, chart.Trellis.ManualLayout,chart.Trellis.ManualRowCount,chart.Trellis.PanelAxis.Expression,chart.Trellis.PageAxis.Expression, chart.Trellis.RowAxis.Expression,chart.Trellis.ColumnAxis.Expression, str(chart.Trellis.ColumnAxis.AxisMode),str(chart.Trellis.ColumnAxis.CategoryMode),str(chart.Trellis.ColumnAxis.EvaluationMode),str(chart.Trellis.PageAxis.AxisMode),str(chart.Trellis.PageAxis.CategoryMode),str(chart.Trellis.PageAxis.EvaluationMode),str(chart.Trellis.RowAxis.AxisMode),str(chart.Trellis.RowAxis.CategoryMode),str(chart.Trellis.RowAxis.EvaluationMode),str(chart.Trellis.PanelAxis.AxisMode),str(chart.Trellis.PanelAxis.CategoryMode),str(chart.Trellis.PanelAxis.EvaluationMode))
        pie_chart_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'show_title':bool(chart.Visual.ShowTitle),
            'table_name':table_ref_name,
            'description':chart.Description,
            'data_filters':get_data_filters(vis),
            'marker_size':float(chart.MarkerSize),
            'sector_axis_mode':str(chart.SectorSizeAxis.AxisMode),
            'sector_expression':chart.SectorSizeAxis.Expression,
            'sector_evaluation_mode':str(chart.SectorSizeAxis.EvaluationMode),
            'sector_category_mode':str(chart.SectorSizeAxis.CategoryMode),
            'sector_name':chart.SectorSizeAxis.Name,
            'show_description':chart.ShowDescription,
            'size_axis_mode':str(chart.SizeAxis.AxisMode),
            'size_binding':chart.SizeAxis.Binding,
            'size_category_mode':str(chart.SizeAxis.CategoryMode),
            'size_evaluation_mode':str(chart.SizeAxis.EvaluationMode),
            'size_data_expression':chart.SizeAxis.Expression,
            'size_name':chart.SizeAxis.Name,
            'size_scale_type':str(chart.SizeAxis.ScaleType),
            'supports_transparency':chart.SupportsTransparency,
            'transparency':chart.Transparency,
            'use_separate_color_for_marked_items':chart.UseSeparateColorForMarkedItems,
            'label_category':chart.VisualAttributes.LabelCategory,
            'label_percentage':chart.VisualAttributes.LabelPercentage,
            'label_percentage_decimal_digits':chart.VisualAttributes.LabelPercentageDecimalDigits,
            'label_percentage_limit':chart.VisualAttributes.LabelPercentageLimit,
            'label_position':str(chart.VisualAttributes.LabelPosition),
            'label_value':chart.VisualAttributes.LabelValue,
            'label_visibility': str(chart.VisualAttributes.LabelVisibility),
            'max_number_of_labels':chart.VisualAttributes.MaxNumberOfLabels,
            'sort_sectors_by_size':chart.VisualAttributes.SortSectorsBySize,
            'legend_obj':legend_obj,
            'trellis':trellis_obj,
            'color_axis':color_axis_obj,
            'show_hide_items':get_show_hide_items(chart)
        }
        

        if type(chart.SizeAxis.Range.High) == type(None):
            pie_chart_obj_dict['size_high_range']=chart.SizeAxis.Range.High
        else:
            pie_chart_obj_dict['size_high_range']=float(chart.SizeAxis.Range.High)
        if type(chart.SizeAxis.Range.Low) == type(None):
            pie_chart_obj_dict['size_low_range']=chart.SizeAxis.Range.Low
        else:
            pie_chart_obj_dict['size_low_range']=float(chart.SizeAxis.Range.Low)
        graph_obj = PieChartMetaData(pie_chart_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'ScatterPlot':

        color_axis_obj =ColorAxis(chart.ColorAxis.Name,chart.ColorAxis.Expression,int(chart.ColorAxis.EvaluationMode),int(chart.ColorAxis.CategoryMode),int(chart.ColorAxis.AxisMode))
        trellis_obj = Trellis(str(chart.Trellis.TrellisMode), chart.Trellis.ManualColumnCount, chart.Trellis.ManualLayout,chart.Trellis.ManualRowCount,chart.Trellis.PanelAxis.Expression,chart.Trellis.PageAxis.Expression, chart.Trellis.RowAxis.Expression,chart.Trellis.ColumnAxis.Expression, str(chart.Trellis.ColumnAxis.AxisMode),str(chart.Trellis.ColumnAxis.CategoryMode),str(chart.Trellis.ColumnAxis.EvaluationMode),str(chart.Trellis.PageAxis.AxisMode),str(chart.Trellis.PageAxis.CategoryMode),str(chart.Trellis.PageAxis.EvaluationMode),str(chart.Trellis.RowAxis.AxisMode),str(chart.Trellis.RowAxis.CategoryMode),str(chart.Trellis.RowAxis.EvaluationMode),str(chart.Trellis.PanelAxis.AxisMode),str(chart.Trellis.PanelAxis.CategoryMode),str(chart.Trellis.PanelAxis.EvaluationMode))
        shape_axis_obj =ShapeAxis(chart.ShapeAxis.Name,chart.ShapeAxis.Expression,int(chart.ShapeAxis.EvaluationMode),int(chart.ShapeAxis.CategoryMode),int(chart.ShapeAxis.AxisMode),int(chart.ShapeAxis.DefaultShape.MarkerType))

        line_connection_dict = {
            'color':str(chart.LineConnection.Color),
            'connection_axis':chart.LineConnection.ConnectionAxis.Expression,
            'is_attached':bool(chart.LineConnection.IsAttached),
            'is_background':bool(chart.LineConnection.IsBackground),
            'order_axis':chart.LineConnection.OrderAxis.Expression,
            'show_arrows':bool(chart.LineConnection.ShowArrows),
            'use_marker_color':bool(chart.LineConnection.UseMarkerColor),
            'width':float(chart.LineConnection.Width)
        }

        pie_marker_dict = {
            'sector_size_axis':chart.PieMarker.SectorSizeAxis.Expression,
            'label_category':chart.PieMarker.VisualAttributes.LabelCategory,
            'label_percentage':chart.PieMarker.VisualAttributes.LabelPercentage,
            'label_percentage_decimal_digits':chart.PieMarker.VisualAttributes.LabelPercentageDecimalDigits,
            'label_percentage_limit':chart.PieMarker.VisualAttributes.LabelPercentageLimit,
            'label_position':str(chart.PieMarker.VisualAttributes.LabelPosition),
            'label_value':chart.PieMarker.VisualAttributes.LabelValue,
            'label_visibility':str(chart.PieMarker.VisualAttributes.LabelVisibility)
        }

        pie_marker_obj = PieMarker(pie_marker_dict)
        line_connection_obj = LineConnection(line_connection_dict)
        x_axis_dict = get_x_axis_properties(chart)
        x_axis_obj = Axis(x_axis_dict)
        y_axis_dict = get_y_axis_properties(chart, chart_graph_flag)
        y_axis_obj = Axis(y_axis_dict)
        fitting_models = get_fitting_models(chart)
        scatterplot_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'show_title':bool(chart.Visual.ShowTitle),
            'table_name':table_ref_name,
            'description':str(chart.Description),
            'data_filters':get_data_filters(vis),
            'drawing_order_axis':chart.DrawingOrderAxis.Expression,
            'drawing_order_reversed':bool(chart.DrawingOrderAxis.Reversed),
            'line_connection':line_connection_obj,
            'marker_by_axis_expression':chart.MarkerByAxis.Expression,
            'marker_class':int(chart.MarkerClass),
            'marker_label_layout':int(chart.MarkerLabelLayout),
            'marker_size':float(chart.MarkerSize),
            'label_column':str(chart.LabelColumn.Expression),
            'label_visibility':int(chart.LabelVisibility),
            'max_number_of_labels':int(chart.MaxNumberOfLabels),
            'pie_marker':pie_marker_obj,
            'rotation_axis':chart.RotationAxis.Expression,
            'rotate_clockwise':bool(chart.RotationAxis.RotateClockwise),
            'shape_axis':shape_axis_obj,
            'show_description':bool(chart.ShowDescription),
            'show_empty_labels':bool(chart.ShowEmptyLabels),
            'show_straight_line_fit':bool(chart.ShowStraightLineFit),
            'size_axis':chart.SizeAxis.Expression,
            'x_axis':x_axis_obj,
            'y_axis':y_axis_obj,
            'x_jitter':float(chart.XJitter),
            'y_jitter':float(chart.YJitter),
            'transparency':chart.Transparency,
            'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
            'trellis':trellis_obj,
            'color_axis':color_axis_obj,
            'fitting_models':fitting_models,
            'legend_obj':legend_obj,
            'show_hide_items':get_show_hide_items(chart)
        }

        graph_obj = ScatterPlotMetaData(scatterplot_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'HeatMap':

        trellis_obj = Trellis(str(chart.Trellis.TrellisMode), chart.Trellis.ManualColumnCount, chart.Trellis.ManualLayout,chart.Trellis.ManualRowCount,chart.Trellis.PanelAxis.Expression,chart.Trellis.PageAxis.Expression, chart.Trellis.RowAxis.Expression,chart.Trellis.ColumnAxis.Expression, str(chart.Trellis.ColumnAxis.AxisMode),str(chart.Trellis.ColumnAxis.CategoryMode),str(chart.Trellis.ColumnAxis.EvaluationMode),str(chart.Trellis.PageAxis.AxisMode),str(chart.Trellis.PageAxis.CategoryMode),str(chart.Trellis.PageAxis.EvaluationMode),str(chart.Trellis.RowAxis.AxisMode),str(chart.Trellis.RowAxis.CategoryMode),str(chart.Trellis.RowAxis.EvaluationMode),str(chart.Trellis.PanelAxis.AxisMode),str(chart.Trellis.PanelAxis.CategoryMode),str(chart.Trellis.PanelAxis.EvaluationMode))
        x_axis_dict = get_x_axis_properties(chart)
        x_axis_obj = Axis(x_axis_dict)
        y_axis_dict = get_y_axis_properties(chart, chart_graph_flag)
        y_axis_obj = Axis(y_axis_dict)
        heat_map_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'show_title':bool(chart.Visual.ShowTitle),
            'table_name':table_ref_name,
            'description':str(chart.Description),
            'data_filters':get_data_filters(vis),
            'show_description':bool(chart.ShowDescription),
            'x_axis':x_axis_obj,
            'y_axis':y_axis_obj,
            'sort_by':str(chart.SortBy),
            'sort_order':str(chart.SortOrder),
            'color_category':str(chart.ColorCategory),
            'col_dendrogram_visible':chart.ColumnDendrogram.Visible,
            'col_data_table_ref':str(chart.ColumnDendrogram.DataTableReference),
            'col_dendogram_man_update':chart.ColumnDendrogram.ManualUpdate,
            'col_dendrogram_dock':str(chart.ColumnDendrogram.Dock),
            'col_dendogram_pruning_colorA':str(chart.ColumnDendrogram.PruningColorA),
            'col_dendogram_pruning_colorB':str(chart.ColumnDendrogram.PruningColorB),
            'col_dendogram_pruning_level':chart.ColumnDendrogram.PruningLevel,
            'col_dendogram_pruning_line_color':str(chart.ColumnDendrogram.PruningLineColor),
            'col_dendogram_show_pruning_line':chart.ColumnDendrogram.ShowPruningLine,
            'col_dendogram_man_use_data_table':chart.ColumnDendrogram.UseDataTable,
            'row_dendrogram_visible':chart.RowDendrogram.Visible,
            'row_data_table_ref':str(chart.RowDendrogram.DataTableReference),
            'row_dendogram_man_update':chart.RowDendrogram.ManualUpdate,
            'row_dendrogram_dock':str(chart.RowDendrogram.Dock),
            'row_dendogram_pruning_colorA':str(chart.RowDendrogram.PruningColorA),
            'row_dendogram_pruning_colorB':str(chart.RowDendrogram.PruningColorB),
            'row_dendogram_pruning_level':chart.RowDendrogram.PruningLevel,
            'row_dendogram_pruning_line_color':str(chart.RowDendrogram.PruningLineColor),
            'row_dendogram_show_pruning_line':chart.RowDendrogram.ShowPruningLine,
            'row_dendogram_man_use_data_table':chart.RowDendrogram.UseDataTable,
            'measure_axis_cat_mode':str(chart.MeasureAxis.CategoryMode),
            'measure_axis_eval_mode':str(chart.MeasureAxis.EvaluationMode),
            'measure_axis_expression':chart.MeasureAxis.Expression,
            'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
            'trellis':trellis_obj,
            'legend_obj':legend_obj,
            'show_hide_items':get_show_hide_items(chart)
        }

        graph_obj = HeatMapMetaData(heat_map_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'CombinationChart':
        fitting_models = get_fitting_models(chart)
        color_axis_obj =ColorAxis(chart.ColorAxis.Name,chart.ColorAxis.Expression,int(chart.ColorAxis.EvaluationMode),int(chart.ColorAxis.CategoryMode),int(chart.ColorAxis.AxisMode))
        trellis_obj = Trellis(str(chart.Trellis.TrellisMode), chart.Trellis.ManualColumnCount, chart.Trellis.ManualLayout,chart.Trellis.ManualRowCount,chart.Trellis.PanelAxis.Expression,chart.Trellis.PageAxis.Expression, chart.Trellis.RowAxis.Expression,chart.Trellis.ColumnAxis.Expression, str(chart.Trellis.ColumnAxis.AxisMode),str(chart.Trellis.ColumnAxis.CategoryMode),str(chart.Trellis.ColumnAxis.EvaluationMode),str(chart.Trellis.PageAxis.AxisMode),str(chart.Trellis.PageAxis.CategoryMode),str(chart.Trellis.PageAxis.EvaluationMode),str(chart.Trellis.RowAxis.AxisMode),str(chart.Trellis.RowAxis.CategoryMode),str(chart.Trellis.RowAxis.EvaluationMode),str(chart.Trellis.PanelAxis.AxisMode),str(chart.Trellis.PanelAxis.CategoryMode),str(chart.Trellis.PanelAxis.EvaluationMode))
        x_axis_dict = get_x_axis_properties(chart)
        x_axis_obj = Axis(x_axis_dict)
        y_axis_dict = get_y_axis_properties(chart,chart_graph_flag)
        y_axis_obj = Axis(y_axis_dict)

        var_series_y=chart.YAxis.Expression.split(',')
        var_series_x=chart.XAxis.Expression.split(',')
        var_series_color=chart.ColorAxis.Expression.split(',')

        y_axis_series_dict = {}
        x_axis_series_dict = {}
        color_axis_series_dict = {}

        for index, series in enumerate(var_series_y):
            y_axis_series_dict[re.sub('[][]','',var_series_y[index]).lstrip()] = str(chart.IndexedSeriesType.Item[re.sub('[][]','',var_series_y[index]).lstrip()])

        for index, series in enumerate(var_series_x):
            x_axis_series_dict[re.sub('[][]','',var_series_x[index]).lstrip()] = str(chart.IndexedSeriesType.Item[re.sub('[][]','',var_series_x[index]).lstrip()])
        var_series_y_processed = []
        for item in var_series_y:
            var_series_y_processed.append(item.replace('[','').replace(']',''))

        color_axis_series_dict = get_color_axis_series_dict(var_series_color,table_ref_name,chart,var_series_y)

        combination_chart_obj_dict = {
                'page_name':page_title,
                'chart_title':chart_title,
                'show_title':bool(chart.Visual.ShowTitle),
                'table_name':table_ref_name,
                'description':str(chart.Description),
                'data_filters':get_data_filters(vis),
                'show_description':bool(chart.ShowDescription),
                'bars_label_complete_bar':bool(chart.Bars.LabelCompleteBar),
                'bars_label_orientation':str(chart.Bars.LabelOrientation),
                'bars_reverse_segment_order':bool(chart.Bars.ReverseSegmentOrder),
                'bars_stack_mode':str(chart.Bars.StackMode),
                'bars_width':float(chart.Bars.Width),
                'label_visibility':str(chart.LabelVisibility),
                'lines_break_on_empty':bool(chart.Lines.BreakOnEmpty),
                'lines_marker_size':float(chart.Lines.MarkerSize),
                'lines_show_marker_labels':bool(chart.Lines.ShowMarkerLabels),
                'lines_show_markers':bool(chart.Lines.ShowMarkers),
                'lines_stepped_lines':bool(chart.Lines.SteppedLines),
                'lines_width':float(chart.Lines.Width),
                'series_legend_item_show_axis_selector':bool(chart.SeriesLegendItem.ShowAxisSelector),
                'series_legend_item_show_title':bool(chart.SeriesLegendItem.ShowTitle),
                'series_legend_item_title':str(chart.SeriesLegendItem.Title),
                'series_legend_item_visible':bool(chart.SeriesLegendItem.Visible),
                'series_type_y_axis':y_axis_series_dict,
                'series_type_x_axis':x_axis_series_dict,
                'series_type_color_axis':color_axis_series_dict,
                'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
                'compensate_for_missing_time_series_values':bool(chart.CompensateForMissingTimeSeriesValues),
                'x_axis':x_axis_obj,
                'y_axis':y_axis_obj,
                'show_hide_items':get_show_hide_items(chart),
                'sort_by_category_key':str(chart.SortBy),
                'max_number_of_labels':int(chart.MaxNumberOfLabels),
                'transparency':chart.Transparency,
                'show_description':bool(chart.ShowDescription),
                'trellis':trellis_obj,
                'legend_obj':legend_obj, 
                'color_axis':color_axis_obj,
                'fitting_models':fitting_models 
        }

        graph_obj = CombinationChartMetaData(combination_chart_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'BoxPlot':
        fitting_models = get_fitting_models(chart)
        color_axis_obj =ColorAxis(chart.ColorAxis.Name,chart.ColorAxis.Expression,int(chart.ColorAxis.EvaluationMode),int(chart.ColorAxis.CategoryMode),int(chart.ColorAxis.AxisMode))
        trellis_obj = Trellis(str(chart.Trellis.TrellisMode), chart.Trellis.ManualColumnCount, chart.Trellis.ManualLayout,chart.Trellis.ManualRowCount,chart.Trellis.PanelAxis.Expression,chart.Trellis.PageAxis.Expression, chart.Trellis.RowAxis.Expression,chart.Trellis.ColumnAxis.Expression, str(chart.Trellis.ColumnAxis.AxisMode),str(chart.Trellis.ColumnAxis.CategoryMode),str(chart.Trellis.ColumnAxis.EvaluationMode),str(chart.Trellis.PageAxis.AxisMode),str(chart.Trellis.PageAxis.CategoryMode),str(chart.Trellis.PageAxis.EvaluationMode),str(chart.Trellis.RowAxis.AxisMode),str(chart.Trellis.RowAxis.CategoryMode),str(chart.Trellis.RowAxis.EvaluationMode),str(chart.Trellis.PanelAxis.AxisMode),str(chart.Trellis.PanelAxis.CategoryMode),str(chart.Trellis.PanelAxis.EvaluationMode))
        x_axis_dict = get_x_axis_properties(chart)
        x_axis_obj = Axis(x_axis_dict)
        y_axis_dict = get_y_axis_properties(chart, chart_graph_flag)
        y_axis_obj = Axis(y_axis_dict)

        box_plot_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'show_title':bool(chart.Visual.ShowTitle),
            'table_name':table_ref_name,
            'description':str(chart.Description),
            'data_filters':get_data_filters(vis),
            'box_width':int(chart.BoxWidth),
            'comparison_circles_alpha_level':chart.ComparisonCircles.AlphaLevel,
            'comparison_circles_span':int(chart.ComparisonCircles.Span),
            'comparison_circles_visible':chart.ComparisonCircles.Visible,
            'marker_size':float(chart.MarkerSize),
            'show_95_perc_confidence':bool(chart.Show95PercentConfidenceInterval),
            'show_description':bool(chart.ShowDescription),
            'show_distribution':chart.ShowDistribution,
            'table_measures':",".join(chart.Table.Measures.ToArray()),
            'table_show_gridlines':str(chart.Table.ShowGridlines),
            'table_sort_measure':str(chart.Table.SortMeasure),
            'table_sort_mode':str(chart.Table.SortMode),
            'table_visible':str(chart.Table.Visible),
            'x_axis':x_axis_obj,
            'y_axis':y_axis_obj,
            'x_jitter':float(chart.XJitter),
            'transparency':chart.Transparency,
            'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
            'use_relative_scale':chart.UseRelativeScale,
            'trellis':trellis_obj,
            'color_axis':color_axis_obj,
            'fitting_models':fitting_models,
            'legend_obj':legend_obj
        }

        graph_obj = BoxPlotMetaData(box_plot_obj_dict)
        return graph_obj
    
    elif chart_graph_flag == 'SummaryTable':

        category_axis_obj = CategoryAxis(chart.CategoryAxis.Name,chart.CategoryAxis.Expression,int(chart.CategoryAxis.EvaluationMode),int(chart.CategoryAxis.CategoryMode),int(chart.CategoryAxis.AxisMode))
        column_list = []
        for column in chart.Columns:
            column_list.append(column.DataColumnName)     

        aggregations = []
        for aggregation in chart.Aggregations:
            aggregations.append(aggregation.MethodName)

         
        summarytable_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'show_title':bool(chart.Visual.ShowTitle),
            'table_name':table_ref_name,
            'aggregations':aggregations,
            'auto_add_new_columns':bool(chart.AutoAddNewColumns),
            'category_axis':category_axis_obj,
            'columns':column_list,
            'data_filters':get_data_filters(vis),
            'description':str(chart.Description),
            'export_data_enabled':bool(chart.ExportDataEnabled),
            'first_column_width':int(chart.FirstColumnWidth),
            'first_row_height':int(chart.FirstRowHeight),
            'legend_obj':legend_obj,
            'show_description':bool(chart.ShowDescription),
            'show_gridlines':bool(chart.ShowGridlines),
            'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
        }

        if chart.SortColumns.Count > 0:
            summarytable_obj_dict['sort_column'] = chart.SortColumns[0].SortColumn.MethodName
            summarytable_obj_dict['sort_order'] = int(chart.SortColumns[0].SortOrder)
        graph_obj = SummaryTableMetaData(summarytable_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'TreeMap':
        color_axis_obj =ColorAxis(chart.ColorAxis.Name,chart.ColorAxis.Expression,int(chart.ColorAxis.EvaluationMode),int(chart.ColorAxis.CategoryMode),int(chart.ColorAxis.AxisMode))
        trellis_obj = Trellis(str(chart.Trellis.TrellisMode), chart.Trellis.ManualColumnCount, chart.Trellis.ManualLayout,chart.Trellis.ManualRowCount,chart.Trellis.PanelAxis.Expression,chart.Trellis.PageAxis.Expression, chart.Trellis.RowAxis.Expression,chart.Trellis.ColumnAxis.Expression, str(chart.Trellis.ColumnAxis.AxisMode),str(chart.Trellis.ColumnAxis.CategoryMode),str(chart.Trellis.ColumnAxis.EvaluationMode),str(chart.Trellis.PageAxis.AxisMode),str(chart.Trellis.PageAxis.CategoryMode),str(chart.Trellis.PageAxis.EvaluationMode),str(chart.Trellis.RowAxis.AxisMode),str(chart.Trellis.RowAxis.CategoryMode),str(chart.Trellis.RowAxis.EvaluationMode),str(chart.Trellis.PanelAxis.AxisMode),str(chart.Trellis.PanelAxis.CategoryMode),str(chart.Trellis.PanelAxis.EvaluationMode))

        tree_map_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'show_title':bool(chart.Visual.ShowTitle),
            'table_name':table_ref_name,
            'data_filters':get_data_filters(vis),
            'description':str(chart.Description),
            'trellis':trellis_obj,
            'legend_obj':legend_obj,
            'color_axis':color_axis_obj,
            'hierarchy_axis_mode':str(chart.HierarchyAxis.AxisMode),
            'hierarchy_axis_category_mode':str(chart.HierarchyAxis.CategoryMode),
            'hierarchy_axis_evaluation_mode':str(chart.HierarchyAxis.EvaluationMode),
            'hierarchy_axis_expression':chart.HierarchyAxis.Expression,
            'hierarchy_axis_name':chart.HierarchyAxis.Name,
            'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
            'show_description':bool(chart.ShowDescription),
            'show_hierarchy_headers':bool(chart.ShowHierarchyHeaders),
            'show_labels':bool(chart.ShowLabels),
            'show_hide_items':get_show_hide_items(chart),
            'size_axis_mode':str(chart.SizeAxis.AxisMode),
            'size_axis_category_mode':str(chart.SizeAxis.CategoryMode),
            'size_axis_evaluation_mode':str(chart.SizeAxis.EvaluationMode),
            'size_axis_expression':chart.SizeAxis.Expression,
            'size_axis_name':chart.SizeAxis.Name
        }

        graph_obj = TreeMapMetaData(tree_map_obj_dict)
        return graph_obj

    elif chart_graph_flag == 'KpiChart':

        kpi_collection = []
        for kpi in chart.KpiCollection:
            kpi_collection.append(get_kpi_vis(kpi.Visualization))

        kpi_chart_obj_dict = {
            'page_name':page_title,
            'chart_title':chart_title,
            'show_title':bool(chart.Visual.ShowTitle),
            'table_name':table_ref_name,
            'active_kpi':get_kpi_vis(chart.ActiveKpi),
            'data_filters':get_data_filters(vis),
            'description':str(chart.Description),
            'kpi_collection':kpi_collection,
            'preferred_tile_width': chart.PreferredTileWidth,
            'show_description':bool(chart.ShowDescription),
            'sort_mode':int(chart.SortMode),
            'use_separate_color_for_marked_items':bool(chart.UseSeparateColorForMarkedItems),
        }

        graph_obj = KpiChartMetaData(kpi_chart_obj_dict)
        return graph_obj
    
def get_kpi_vis(kpi_vis):
    kpi_color_axis_obj =ColorAxis(kpi_vis.ColorAxis.Name,kpi_vis.ColorAxis.Expression,int(kpi_vis.ColorAxis.EvaluationMode),int(kpi_vis.ColorAxis.CategoryMode),int(kpi_vis.ColorAxis.AxisMode))
    kpi_comparative_axis_obj =ComparativeAxis(kpi_vis.ComparativeAxis.Name,kpi_vis.ComparativeAxis.Expression,int(kpi_vis.ComparativeAxis.EvaluationMode),int(kpi_vis.ComparativeAxis.CategoryMode),int(kpi_vis.ComparativeAxis.AxisMode))

    kpi_vis_dict = {
        'color_axis':kpi_color_axis_obj,
        'comparative_axis':kpi_comparative_axis_obj,
        'description':kpi_vis.Description,
        'empty_tile_color':str(kpi_vis.EmptyTileColor),
        'empty_tile_text':kpi_vis.EmptyTileText,
        'include_origin':bool(kpi_vis.IncludeOrigin),
        'show_description':bool(kpi_vis.ShowDescription),
        'show_hide_items':get_show_hide_items(kpi_vis),
        'show_sparkline':bool(kpi_vis.ShowSparkline),
        'show_sparkline_scale':bool(kpi_vis.ShowSparklineScale),
        'show_x_label_in_tile':bool(kpi_vis.ShowXLabelInTile),
        'sort_column':kpi_vis.SortColumn.Expression,
        'data_table_ref':kpi_vis.Data.DataTableReference.Name,
        'tile_axis':kpi_vis.TileAxis.Expression,
        'title':kpi_vis.Title,
        'use_separate_color_for_marked_items':bool(kpi_vis.UseSeparateColorForMarkedItems),
        'x_axis': kpi_vis.XAxis.Expression,
        'y_axis':kpi_vis.YAxis.Expression
    }

    if ':' in kpi_vis.Data.DataTableReference.Name:
        kpi_vis_dict['data_table_ref'] = (kpi_vis.Data.DataTableReference.Name).split(':')[1]

    return KpiVisualizationMetaData(kpi_vis_dict)


def get_fitting_models(chart):
    '''
    Gets the lines and curves properties of charts
    Arguments:

        chart {object} -- chart object
        chart_graph_flag {string} -- chart type

    Returns:
        fitting_models {list} -- list of fitting model dictionaries

    '''

    fitting_models = []
    for fitting_model in chart.FittingModels:
        fm_name = str(fitting_model.TypeId.Name)
        
        fitting_model_dict = {
            'name':fm_name,
            'curve_line': None,
            'data_table_ref':None,
            'display_name':str(fitting_model.TypeId.DisplayName),
            'enabled':bool(fitting_model.Enabled),
            'individual_fitting_mode':str(fitting_model.IndividualFittingModes),
            'manual_update':bool(fitting_model.ManualUpdate),
            'is_horizontal': False,
            'expression': '',
            'degree':0,
            'assumed_x_transform_type':0,
            'has_fixed_min':False,
            'has_fixed_max':False,
            'fixed_max':0,
            'fixed_min':0,
            'inflection_point':'',
            'amplitude':0.0,
            'amplitude_is_fixed':False,
            'position':0.0,
            'position_is_fixed':False,
            'width':0.0,
            'width_is_fixed':False,
            'allow_empty_value_replacement':False,
            'automatic_frequency':False,
            'confidence_curve':None,
            'confidence_level':0.0,
            'fitted_curve':None,
            'forecast_curve':None,
            'frequency':0,
            'frequency_expression':'',
            'level':0.0,
            'seasonal':0.0,
            'seasonal_model_type':0,
            'time_points_ahead':0,
            'time_points_ahead_expression':'',
            'trend':0.0,
            'use_seasonal':False,
            'use_trend':False,
            'x_column_ref':None,
            'y_column_ref':None,
            'sort_column_ref':None,
            'break_on_empty':False,
            'affect_axis_ranges':False,
            'data_table_detail_items_expression':'',
            'data_table_enabled':False,
            'begin_expression':'',
            'end_expression':'',
            'use_axis_transform':False
        }
 
        if fm_name == "Spotfire.ColumnValuesLine":
            
            fitting_model_dict['data_table_ref'] = fitting_model.DataTableReference.Name
            if ':' in fitting_model.DataTableReference.Name:
                fitting_model_dict['data_table_ref'] = (fitting_model.DataTableReference.Name).split(':')[1]
        
            fitting_model_dict['x_column_ref'] = fitting_model.XColumnReference.Name
            fitting_model_dict['y_column_ref'] = fitting_model.YColumnReference.Name
            fitting_model_dict['break_on_empty'] = bool(fitting_model.BreakOnEmpty)
            fitting_model_dict['affect_axis_ranges'] = bool(fitting_model.AffectAxisRanges)
            if fitting_model.SortColumnReference != None:
                fitting_model_dict['sort_column_ref'] = fitting_model.SortColumnReference.Name
  
        if 'Line' in fm_name:
            fitting_model_dict['curve_line'] = get_curve_line_obj(fitting_model.Line)

        curve_list = ['Spotfire.LogisticRegressionFittingModel', 'Spotfire.PolynomialFittingModel', 'Spotfire.GaussianFittingModel',
                        'Spotfire.ExponentialFittingModel', 'Spotfire.LogarithmicFittingModel', 'Spotfire.PowerFittingModel']
        if 'Curve' in fm_name or fm_name in curve_list:
            fitting_model_dict['curve_line'] = get_curve_line_obj(fitting_model.Curve)

        
        if fm_name == "Spotfire.ReferenceLineFittingModel":
            fitting_model_dict['is_horizontal'] = bool(fitting_model.IsHorizontal)
            fitting_model_dict['expression'] = str(fitting_model.Expression)

        if fm_name == "Spotfire.ReferenceCurveFromTableFittingModel" or fm_name == "Spotfire.ReferenceLineFromTableFittingModel":
            fitting_model_dict['data_table_enabled'] = fitting_model.DataTableEnabled
            if fitting_model_dict['data_table_enabled']:     
                fitting_model_dict['data_table_ref'] = fitting_model.DataTableReference.Name
                if ':' in fitting_model.DataTableReference.Name:
                    fitting_model_dict['data_table_ref'] = (fitting_model.DataTableReference.Name).split(':')[1]
                fitting_model_dict['data_table_detail_items_expression'] = fitting_model.DataTableDetailItemsExpression
            fitting_model_dict['expression'] = str(fitting_model.Expression)
            

        if fm_name == "Spotfire.ReferenceCurveFromTableFittingModel":
            fitting_model_dict['begin_expression'] = str(fitting_model.BeginExpression)
            fitting_model_dict['end_expression'] = str(fitting_model.EndExpression)
          
        if fm_name == "Spotfire.ReferenceLineFromTableFittingModel":
            fitting_model_dict['is_horizontal'] = bool(fitting_model.IsHorizontal)
            fitting_model_dict['affect_axis_ranges'] = bool(fitting_model.AffectAxisRanges)
            fitting_model_dict['use_axis_transform'] = bool(fitting_model.UseAxisTransform)

        if fm_name == "Spotfire.PolynomialFittingModel":
            fitting_model_dict['degree'] = int(fitting_model.Degree)
       
        
        if fm_name == "Spotfire.LogisticRegressionFittingModel":
            fitting_model_dict['assumed_x_transform_type'] = int(fitting_model.AssumedXTransformType)
            fitting_model_dict['has_fixed_min'] = bool(fitting_model.HasFixedMin)
            fitting_model_dict['has_fixed_max'] = bool(fitting_model.HasFixedMax)
            fitting_model_dict['fixed_max'] = int(fitting_model.FixedMax)
            fitting_model_dict['fixed_min'] = int(fitting_model.FixedMin)
            inflection_point_dict = {
                'affect_axis_ranges':bool(fitting_model.InflectionPoint.AffectAxisRanges),
                'color':str(fitting_model.InflectionPoint.Color),
                'custom_display_name':str(fitting_model.InflectionPoint.CustomDisplayName),
                'is_background':bool(fitting_model.InflectionPoint.IsBackground),
                'marker_shape':int(fitting_model.InflectionPoint.MarkerShape.MarkerType),
                'size':float(fitting_model.InflectionPoint.Size),
                'visible':bool(fitting_model.InflectionPoint.Visible)

            }

            inflection_point_obj = InflectionPoint(inflection_point_dict)
            fitting_model_dict['inflection_point'] = inflection_point_obj

   
        if fm_name == "Spotfire.GaussianFittingModel":
            fitting_model_dict['amplitude'] = fitting_model.Amplitude
            fitting_model_dict['amplitude_is_fixed'] = bool(fitting_model.AmplitudeIsFixed)
            fitting_model_dict['position'] = fitting_model.Position
            fitting_model_dict['position_is_fixed'] = fitting_model.PositionIsFixed
            fitting_model_dict['width'] = fitting_model.Width
            fitting_model_dict['width_is_fixed'] = fitting_model.WidthIsFixed

        if fm_name == "Spotfire.ForecastHoltWintersFittingModel":
            fitting_model_dict['allow_empty_value_replacement'] = bool(fitting_model.AllowEmptyValueReplacement)
            fitting_model_dict['automatic_frequency'] = bool(fitting_model.AutomaticFrequency)
            fitting_model_dict['confidence_curve'] = get_curve_line_obj(fitting_model.ConfidenceCurve)
            fitting_model_dict['confidence_level'] = fitting_model.ConfidenceLevel
            fitting_model_dict['fitted_curve'] = get_curve_line_obj(fitting_model.FittedCurve)
            fitting_model_dict['forecast_curve'] = get_curve_line_obj(fitting_model.ForecastCurve)
            fitting_model_dict['frequency'] = int(fitting_model.Frequency)
            fitting_model_dict['frequency_expression'] = str(fitting_model.FrequencyExpression)
            fitting_model_dict['level'] = fitting_model.Level
            fitting_model_dict['seasonal'] = fitting_model.Seasonal
            fitting_model_dict['seasonal_model_type'] = int(fitting_model.SeasonalModelType)
            fitting_model_dict['time_points_ahead'] = int(fitting_model.TimePointsAhead)
            fitting_model_dict['time_points_ahead_expression'] = str(fitting_model.TimePointsAheadExpression)
            fitting_model_dict['trend'] = fitting_model.Trend
            fitting_model_dict['use_seasonal'] = bool(fitting_model.UseSeasonal)
            fitting_model_dict['use_trend'] = bool(fitting_model.UseTrend)

        fitting_model_obj = FittingModel(fitting_model_dict)
        fitting_models.append(fitting_model_obj)
    
    return fitting_models

        
def get_curve_line_obj(fitting_model_curve_line):
    '''
    Creates and returns properties of a given curve/line

    Arguments:
        fitting_model_curve_line {object} -- Curve or Line object
    
    Returns:
        CurveLine {object} -- object containing curve or line properties
    '''

    curve_line_dict = {
        'custom_display_name':str(fitting_model_curve_line.CustomDisplayName),
        'expression':str(fitting_model_curve_line.Expression),
        'is_background':bool(fitting_model_curve_line.IsBackground),
        'line_style':int(fitting_model_curve_line.LineStyle),
        'line_width':int(fitting_model_curve_line.Width),
        'color':str(fitting_model_curve_line.Color),
        'visible':bool(fitting_model_curve_line.Visible)
    }
    
            
    fitting_model_details = []
    for detail in fitting_model_curve_line.Details:
        fitting_model_details.append(FittingModelDetails(detail.Name, detail.ShowInLabel, detail.ShowInTooltip))

    curve_line_dict['details'] = fitting_model_details
    return CurveLine(curve_line_dict)


def get_color_axis_series_dict(var_series_color,table_ref_name,chart,var_series_y):
    """
    Creates and returns dictionary of color axis series properties

    Arguments:
        var_series_color {List} -- list of cols selected in color axis
        table_ref_name {String} -- referenced table name
        chart {object} -- chart object
        var_series_y {object} -- list of cols selected in Y axis

    Returns:
        color_axis_series_dict {dict} -- dictionary of color axis series properties

    """
    color_axis_series_dict = {}

    for column_name in var_series_color:
        category_dict = {}
        column_name = column_name.replace('<','').replace('[','').replace('>','').replace(']','')
        table_name=table_ref_name
        if mode == 'Edit':
            table_name = report_name + ':' + table_ref_name 
        active_table=Document.Data.Tables[table_name]
        row_count = active_table.RowCount
        rows_to_include = IndexSet(row_count,True)
        found,column=active_table.Columns.TryGetValue(column_name)
        if found:
            cursor = DataValueCursor.CreateFormatted(active_table.Columns[column_name])
            ctrl = 0
            uc=dict()
            for row in active_table.GetRows(rows_to_include,cursor):
                val = cursor.CurrentValue
                uc.update({val:ctrl})
                ctrl = ctrl + 1
            for key in uc:
                category_dict[key] = str(chart.IndexedSeriesType.Item[key])
            color_axis_series_dict[column_name] = category_dict

        else:
            if column_name == 'Axis.Default.Names':
                for column_name in var_series_y:
                    column_name = column_name.replace('[','').replace(']','').replace(' ','')
                    category_dict[column_name] = str(chart.IndexedSeriesType.Item[column_name])
                color_axis_series_dict[column_name] = category_dict
            elif column_name == 'Axis.Subsets.Names':
                category_dict['Current filtering'] = str(chart.IndexedSeriesType.Item['Current filtering'])
                color_axis_series_dict[column_name] = category_dict
            elif column_name == 'baserowid()':
                row_count = active_table.RowCount
                for x in range (1, row_count+1):
                    category_dict[int(x)] = str(chart.IndexedSeriesType.Item[x])
                color_axis_series_dict[column_name] = category_dict

    return color_axis_series_dict


def get_show_hide_items(chart):
    """
    Creates and returns Show/Hide Items class

    Arguments:
        chart {object} -- chart object

    Returns:
        Show/Hide Items class {Class} -- Show/Hide Items class

    """
    threshold_rules_list = []
    top_bottom_rules_list = []
    string_rules_list = []
    range_rules_list = []
    expression_rules_list = []
    found, rules = chart.TryGetFilterRules()
    for rule in rules:
        if 'TopBottomRuleCondition' in rule.RuleCondition.ToString():
            rule_obj = TopBottomRuleMetaData(get_top_bottom_rule_condition(rule))
            top_bottom_rules_list.append(rule_obj)
        elif 'ThresholdRuleCondition' in rule.RuleCondition.ToString():
            rule_obj = ThresholdRuleMetaData(get_threshold_rule_condition(rule))
            threshold_rules_list.append(rule_obj)
        elif 'StringRuleCondition' in rule.RuleCondition.ToString():
            rule_obj = StringRuleMetaData(get_string_rule_condition(rule))
            string_rules_list.append(rule_obj)
        elif 'RangeRuleCondition' in rule.RuleCondition.ToString():
            rule_obj = RangeRuleMetaData(get_range_rule_condition(rule))
            range_rules_list.append(rule_obj)
        else:
            rule_obj = ExpressionRuleMetaData(get_expression_rule_condition(rule))
            expression_rules_list.append(rule_obj)

    return ShowHideItems(threshold_rules_list,top_bottom_rules_list,string_rules_list,range_rules_list,expression_rules_list)
   

def get_top_bottom_rule_condition(rule):
    """
    Creates and returns TopBottom rule properties dictionary

    Arguments:
        rule {object} -- rule object

    Returns:
        top_bottom_rule_dict {dict} -- dictionary of rule's properties

    """
    top_bottom_rule_dict = {
                'display_name':rule.DisplayName,
                'expression':rule.Expression,
                'rule_condition_is_bottom':bool(rule.RuleCondition.IsBottom),
                'rule_condition_rank_type':str(rule.RuleCondition.Rank.Type),
                'rule_condition_rank_value':rule.RuleCondition.Rank.Value,
                'rule_condition_rank_manual_display_name':rule.RuleCondition.RankManualDisplayName,
                'hide_matched_items':bool(rule.HideMatchedItems),
                'evaluate_per_trellis':bool(rule.EvaluatePerTrellis),
                'enabled':bool(rule.Enabled)
                }
    return top_bottom_rule_dict


def get_string_rule_condition(rule):
    """
    Creates and returns String rule properties dictionary

    Arguments:
        rule {object} -- rule object

    Returns:
        string_rule_dict {dict} -- dictionary of rule's properties
        
    """
    string_rule_dict = {
                'display_name':rule.DisplayName,
                'expression':rule.Expression,
                'rule_condition_comparison_operator':str(rule.RuleCondition.ComparisonOperator),
                'rule_condition_string_type':str(rule.RuleCondition.StringValue.Type),
                'rule_condition_string_value':rule.RuleCondition.StringValue.Value,
                'rule_condition_string_manual_display_name':rule.RuleCondition.StringValueManualDisplayName,
                'hide_matched_items':bool(rule.HideMatchedItems),
                'evaluate_per_trellis':bool(rule.EvaluatePerTrellis),
                'enabled':bool(rule.Enabled)
                }
    return string_rule_dict


def get_range_rule_condition(rule):
    """
    Creates and returns Range rule properties dictionary

    Arguments:
        rule {object} -- rule object

    Returns:
        range_rule_dict {dict} -- dictionary of rule's properties
        
    """
    range_rule_dict = {
                'display_name':rule.DisplayName,
                'expression':rule.Expression,
                'rule_condition_end_value_type':str(rule.RuleCondition.EndValue.Type),
                'rule_condition_end_value_value':rule.RuleCondition.EndValue.Value,
                'rule_condition_start_value_type':str(rule.RuleCondition.StartValue.Type),
                'rule_condition_start_value_value':rule.RuleCondition.StartValue.Value,
                'rule_condition_end_value_manual_display_name':rule.RuleCondition.EndValueManualDisplayName,
                'rule_condition_start_value_manual_display_name':rule.RuleCondition.StartValueManualDisplayName,
                'hide_matched_items':bool(rule.HideMatchedItems),
                'evaluate_per_trellis':bool(rule.EvaluatePerTrellis),
                'enabled':bool(rule.Enabled)
                }
    return range_rule_dict


def get_expression_rule_condition(rule):
    """
    Creates and returns Expression rule properties dictionary

    Arguments:
        rule {object} -- rule object

    Returns:
        expression_rule_dict {dict} -- dictionary of rule's properties
        
    """
    expression_rule_dict = {
                'display_name':rule.DisplayName,
                'expression':rule.Expression,
                'rule_condition_expression':str(rule.RuleCondition.Expression),
                'hide_matched_items':bool(rule.HideMatchedItems),
                'evaluate_per_trellis':bool(rule.EvaluatePerTrellis),
                'enabled':bool(rule.Enabled)
                }
    return expression_rule_dict


def get_threshold_rule_condition(rule):
    """
    Creates and returns Threshold rule properties dictionary

    Arguments:
        rule {object} -- rule object

    Returns:
        threshold_rule_dict {dict} -- dictionary of rule's properties
        
    """
    threshold_rule_dict = {
                'display_name':rule.DisplayName,
                'expression':rule.Expression,
                'rule_condition_comparison_operator':str(rule.RuleCondition.ComparisonOperator),
                'rule_condition_threshold_type':str(rule.RuleCondition.Threshold.Type),
                'rule_condition_threshold_value':rule.RuleCondition.Threshold.Value,
                'rule_condition_threshold_manual_display_name':rule.RuleCondition.ThresholdManualDisplayName,
                'hide_matched_items':bool(rule.HideMatchedItems),
                'evaluate_per_trellis':bool(rule.EvaluatePerTrellis),
                'enabled':bool(rule.Enabled)
                }
    return threshold_rule_dict


def get_x_axis_properties(chart):
    """
    Gets x axis attributes

    Arguments:
        chart

    Returns:
        x_axis_dict {dictionary} -- dictionary containing x axis attributes
        
    """
    x_axis_dict = {
            'axis_name':chart.XAxis.Name,
            'expression':chart.XAxis.Expression,
            'category_mode':int(chart.XAxis.CategoryMode),
            'evaluation_mode':int(chart.XAxis.EvaluationMode),
            'manual_zoom':bool(chart.XAxis.ManualZoom),           
            'reversed':bool(chart.XAxis.Reversed),
            'scale_dock':int(chart.XAxis.Scale.Dock),
            'label_layout':int(chart.XAxis.Scale.LabelLayout),
            'label_orientation':int(chart.XAxis.Scale.LabelOrientation),
            'max_num_ticks':int(chart.XAxis.Scale.MaximumNumberOfTicks),
            'show_gridlines':bool(chart.XAxis.Scale.ShowGridlines),
            'show_labels':bool(chart.XAxis.Scale.ShowLabels),
            'show_axis_selector':bool(chart.XAxis.ShowAxisSelector),
            'transform_type':int(chart.XAxis.TransformType),
            'include_zero_in_auto_zoom':bool(chart.XAxis.IncludeZeroInAutoZoom)
    }
    if chart.XAxis.Range.High is not None:
        x_axis_dict['range_high'] = float(chart.XAxis.Range.High)

    if chart.XAxis.Range.Low is not None:
        x_axis_dict['range_low'] = float(chart.XAxis.Range.Low)

    if chart.XAxis.ManualZoom == True:
        if chart.XAxis.ZoomRange.High is None and chart.XAxis.Range.High is not None:
            x_axis_dict['zoom_range_high'] = float(chart.XAxis.Range.High)
        elif chart.XAxis.ZoomRange.High is not None:
            x_axis_dict['zoom_range_high'] = float(chart.XAxis.ZoomRange.High)

        if chart.XAxis.ZoomRange.Low is None and chart.XAxis.Range.Low is not None:
            x_axis_dict['zoom_range_low'] = float(chart.XAxis.Range.Low)
        elif chart.XAxis.ZoomRange.Low is not None:
            x_axis_dict['zoom_range_low'] = float(chart.XAxis.ZoomRange.Low)
    
    return x_axis_dict

        
def get_y_axis_properties(chart, chart_graph_flag):
    """
    Gets y axis attributes

    Arguments:
        chart

    Returns:
        y_axis_dict {dictionary} -- dictionary containing y axis attributes
        
    """
    y_axis_dict = {
            'axis_name':chart.YAxis.Name,
            'expression':chart.YAxis.Expression,
            'category_mode':int(chart.YAxis.CategoryMode),
            'evaluation_mode':int(chart.YAxis.EvaluationMode),
            'include_zero_in_auto_zoom':bool(chart.YAxis.IncludeZeroInAutoZoom),
            'manual_zoom':bool(chart.YAxis.ManualZoom),           
            'reversed':bool(chart.YAxis.Reversed),
            'scale_dock':int(chart.YAxis.Scale.Dock),
            'scale_far_span':float(chart.YAxis.Scale.FarSpan),
            'label_layout':int(chart.YAxis.Scale.LabelLayout),
            'label_orientation':int(chart.YAxis.Scale.LabelOrientation),
            'max_num_ticks':int(chart.YAxis.Scale.MaximumNumberOfTicks),
            'show_gridlines':bool(chart.YAxis.Scale.ShowGridlines),
            'show_labels':bool(chart.YAxis.Scale.ShowLabels),
            'show_axis_selector':bool(chart.YAxis.ShowAxisSelector),
            'transform_type':int(chart.YAxis.TransformType)
    }

    if chart_graph_flag == "ScatterPlot" or chart_graph_flag == 'CombinationChart' or chart_graph_flag == 'BarChart' or chart_graph_flag == 'LineGraph':
        y_axis_dict['individual_scaling'] = bool(chart.YAxis.IndividualScaling)
        y_axis_dict['individual_scaling_mode'] = int(chart.YAxis.IndividualScalingMode)
        y_axis_dict['indexed_include_zero_in_auto_zoom'] = bool(chart.YAxis.IndexedIncludeZeroInAutoZoom.RootValue)
        y_axis_dict['indexed_dock'] = int(chart.YAxis.Scale.IndexedDock.RootValue)
        y_axis_dict['indexed_reversed'] = bool(chart.YAxis.IndexedReversed.RootValue)
        y_axis_dict['indexed_transform_type'] = int(chart.YAxis.IndexedTransformType.RootValue)

    if chart.YAxis.Range.High is not None:
        y_axis_dict['range_high'] = float(chart.YAxis.Range.High)

    if chart.YAxis.Range.Low is not None:
        y_axis_dict['range_low'] = float(chart.YAxis.Range.Low)

    if chart.YAxis.ManualZoom == True:
        if chart.YAxis.ZoomRange.High is None and chart.YAxis.Range.High is not None:
            y_axis_dict['zoom_range_high'] = float(chart.YAxis.Range.High)
        elif chart.YAxis.ZoomRange.High is not None:
            y_axis_dict['zoom_range_high'] = float(chart.YAxis.ZoomRange.High)

        if chart.YAxis.ZoomRange.Low is None and chart.YAxis.Range.Low is not None:
            y_axis_dict['zoom_range_low'] = float(chart.YAxis.Range.Low)

        elif chart.YAxis.ZoomRange.Low is not None:
            y_axis_dict['zoom_range_low'] = float(chart.YAxis.ZoomRange.Low)

    # sets left/right scale ranges if scale category mode is Dual
    left_scale = []
    right_scale = []
    if int(chart.YAxis.IndividualScalingMode) == 2:
        
        # Sort category keys into left/right scales
        keys=List[CategoryKey]()
        keys=chart.ColorAxis.Coloring.AddCategoricalColorRule().GetExplicitCategories()
        
        for key in keys:
            if chart.YAxis.Scale.IndexedDock[key] == ScaleDock.Near:
                left_scale.append(str(key))
            else:
                right_scale.append(str(key))

        y_axis_dict['indexed_left_scale'] = left_scale
        y_axis_dict['indexed_right_scale'] = right_scale
        y_axis_dict['indexed_left_show_labels'] = bool(chart.YAxis.Scale.IndexedShowLabels[ScaleDock.Near])
        y_axis_dict['indexed_right_show_labels'] = bool(chart.YAxis.Scale.IndexedShowLabels[ScaleDock.Far])
        y_axis_dict['indexed_left_show_gridlines'] = bool(chart.YAxis.Scale.IndexedShowGridlines[ScaleDock.Near])
        y_axis_dict['indexed_right_show_gridlines'] = bool(chart.YAxis.Scale.IndexedShowGridlines[ScaleDock.Far])
        y_axis_dict['indexed_left_reversed'] = bool(chart.YAxis.IndexedReversed[ScaleDock.Near])
        y_axis_dict['indexed_right_reversed'] = bool(chart.YAxis.IndexedReversed[ScaleDock.Far])
        y_axis_dict['indexed_left_transform_type'] = int(chart.YAxis.IndexedTransformType[ScaleDock.Near])
        y_axis_dict['indexed_right_transform_type'] = int(chart.YAxis.IndexedTransformType[ScaleDock.Far])
        y_axis_dict['indexed_left_label_orientation'] = int(chart.YAxis.Scale.IndexedLabelOrientation[ScaleDock.Near])
        y_axis_dict['indexed_right_label_orientation'] = int(chart.YAxis.Scale.IndexedLabelOrientation[ScaleDock.Far])
        y_axis_dict['indexed_left_max_num_ticks'] = int(chart.YAxis.Scale.IndexedMaximumNumberOfTicks[ScaleDock.Near])
        y_axis_dict['indexed_right_max_num_ticks'] = int(chart.YAxis.Scale.IndexedMaximumNumberOfTicks[ScaleDock.Far])
        y_axis_dict['indexed_left_label_layout'] = int(chart.YAxis.Scale.IndexedScaleLabelLayout[ScaleDock.Near])
        y_axis_dict['indexed_right_label_layout'] = int(chart.YAxis.Scale.IndexedScaleLabelLayout[ScaleDock.Far])

        if chart.YAxis.IndexedRange[ScaleDock.Near].High is not None:
            y_axis_dict['indexed_left_range_high'] = float(chart.YAxis.IndexedRange[ScaleDock.Near].High)
        
        if chart.YAxis.IndexedRange[ScaleDock.Near].Low is not None:
            y_axis_dict['indexed_left_range_low'] = float(chart.YAxis.IndexedRange[ScaleDock.Near].Low)

        if chart.YAxis.IndexedRange[ScaleDock.Far].High is not None:
            y_axis_dict['indexed_right_range_high'] = float(chart.YAxis.IndexedRange[ScaleDock.Far].High)
        
        if chart.YAxis.IndexedRange[ScaleDock.Far].Low is not None:
            y_axis_dict['indexed_right_range_low'] = float(chart.YAxis.IndexedRange[ScaleDock.Far].Low)

    
    y_axis_dict['indexed_show_gridlines'] = bool(chart.YAxis.Scale.IndexedShowGridlines.RootValue)
    y_axis_dict['indexed_show_labels'] = bool(chart.YAxis.Scale.IndexedShowLabels.RootValue)
    y_axis_dict['indexed_label_orientation'] = int(chart.YAxis.Scale.IndexedLabelOrientation.RootValue)
    y_axis_dict['indexed_max_num_ticks'] = int(chart.YAxis.Scale.IndexedMaximumNumberOfTicks.RootValue)
    y_axis_dict['indexed_label_layout'] = int(chart.YAxis.Scale.IndexedScaleLabelLayout.RootValue)
  
    return y_axis_dict


def get_name_in_report(name):
    '''
    Adds report name prefix to page title/table name if report name not present in the string

    Arguments:
        name {String} -- page title name/table name

    Returns:
        name {String} -- updated/not updated string with added report prefix
        
    '''
    
    if name is not None:
        if mode == 'Edit':
            if report_name != selected_report:
                if ':' in name:
                    return report_name+ ':'+name.split(':')[1]
            else:
                if ':' not in name:
                    return report_name+ ':'+name
                else:
                    return name
        else:
            if ':' not in name:
                return report_name+ ':'+name
            else:
                return name 


def get_page_objects():
    """
    Gets all available graph objects and stores them in Graphs class object

    Returns:
        page_list {class} -- list of the pages and their visualizations
        
    """

    page_list = []
    
    for page in Document.Pages:
        bar_graph_list = []
        line_graph_list = []
        table_plot_list = []
        cross_table_list = []
        pie_chart_list = []
        scatterplot_list = []
        heat_map_list = []
        combination_chart_list = []
        box_plot_list = []
        summary_table_list = []
        tree_map_list = []
        kpi_chart_list = []
        page_title = get_name_in_report(page.Title)
        if page.Title not in pmex_page_list:
            for vis in page.Visuals:
                if (str(vis.TypeId) ==  "TypeIdentifier:Spotfire.Table") and vis.Title != 'Datetime Interval Definitions':
                    chart = vis.As[TablePlot]()
                    table_plot_list.append(get_graph_objects_attributes(chart,page,'TablePlot', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.BarChart):
                    chart = vis.As[BarChart]()
                    bar_graph_list.append(get_graph_objects_attributes(chart, page, 'BarChart', vis))   
                elif (vis.TypeId == VisualTypeIdentifiers.LineChart):
                    chart = vis.As[LineChart]()
                    line_graph_list.append(get_graph_objects_attributes(chart, page, 'LineGraph', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.CrossTable):
                    chart = vis.As[CrossTablePlot]()
                    cross_table_list.append(get_graph_objects_attributes(chart, page, 'CrossTable', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.PieChart):
                    chart = vis.As[PieChart]()
                    pie_chart_list.append(get_graph_objects_attributes(chart, page, 'PieChart', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.ScatterPlot):
                    chart = vis.As[ScatterPlot]()
                    scatterplot_list.append(get_graph_objects_attributes(chart, page, 'ScatterPlot', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.HeatMap):
                    chart = vis.As[HeatMap]()
                    heat_map_list.append(get_graph_objects_attributes(chart, page, 'HeatMap', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.CombinationChart):
                    chart = vis.As[CombinationChart]()
                    combination_chart_list.append(get_graph_objects_attributes(chart, page, 'CombinationChart', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.BoxPlot):
                    chart = vis.As[BoxPlot]()
                    box_plot_list.append(get_graph_objects_attributes(chart, page, 'BoxPlot', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.SummaryTable):
                    chart = vis.As[SummaryTable]()
                    summary_table_list.append(get_graph_objects_attributes(chart, page, 'SummaryTable', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.Treemap):
                    chart = vis.As[Treemap]()
                    tree_map_list.append(get_graph_objects_attributes(chart, page, 'TreeMap', vis))
                elif (vis.TypeId == VisualTypeIdentifiers.KpiChart):
                    chart = vis.As[KpiChart]()
                    kpi_chart_list.append(get_graph_objects_attributes(chart, page, 'KpiChart', vis))
            page_list.append(Page(page_title , Graphs(table_plot_list, bar_graph_list,line_graph_list, cross_table_list, pie_chart_list, scatterplot_list, heat_map_list,combination_chart_list, box_plot_list, summary_table_list, tree_map_list, kpi_chart_list)))
            
    return page_list


def build_table_object_list():
    '''
    Creates table object with corresponding attributes for each table to be saved in the report

    Returns:
        table_object_list {list} -- list of the tables objects
        
    '''
    table_object_list= []
    for table in report_table_list_json:
        table_obj = Document.Data.Tables[table]
        table_obj_dict = {
            'table_name':get_name_in_report(table),
            'table_source':get_table_source_object(table_obj),
            'table_column_operation':get_column_operations(table_obj),
            'table_operations':get_table_operations(table_obj),
            'table_transformations':get_table_transformations(table_obj)
        }
        table_object_list.append(Table(table_obj_dict))
    return table_object_list


def get_table_source_object(table_obj):
    '''
    Retrieves data table source. It can SQl query/Information Link/Other data table as a source table

    Arguments:
        table_obj {Object} -- table object

    Returns:
        TableSource {Class} -- table source class and its' parameters
        
    '''
    
    tbl_conn_obj_list = []
    tbl_data_source_obj_List = []
    tbl_il_list = []
    tbl_file_list = []
    source_view = table_obj.GenerateSourceView()
    data_operations=source_view.GetAllOperations[DataOperation]()
    for data_operation in data_operations:
        if type(data_operation).__name__ == 'DataSourceOperation':
            source_tbl_data_source = data_operation.GetDataFlow().DataSource
            if(type(source_tbl_data_source).__name__ == "DatabaseDataSource"):
                tbl_conn_obj_list.append(TableConnection(source_tbl_data_source.Settings.ConnectionString,source_tbl_data_source.Settings.Provider,source_tbl_data_source.Settings.SqlStatement))
            elif(type(source_tbl_data_source).__name__  == "InformationLinkDataSource"):
                found=source_tbl_data_source.FindAll("id::"+str(source_tbl_data_source.Id))
                path = found.First.Path
                tbl_il_list.append(InformationLinkDataSource(str(source_tbl_data_source.Id),path))
            elif(type(source_tbl_data_source).__name__  == "Excel2FileDataSource") :
                tbl_file_list.append(FileDataSource('Excel',source_tbl_data_source.Name,source_tbl_data_source.FilePath,None))
            elif type(source_tbl_data_source).__name__  ==   "TextFileDataSource":
                if not source_tbl_data_source.DataOriginIsStream:
                    tbl_file_list.append(FileDataSource('TextFile',source_tbl_data_source.Name,source_tbl_data_source.FilePath,source_tbl_data_source.Settings.Separator))
                else:
                    print 'Data source is not supported: Stream. Ignoring table ...'
                    break
            elif (type(source_tbl_data_source).__name__  == "FileDataSource"):
                if not source_tbl_data_source.DataOriginIsStream:
                    tbl_file_list.append(FileDataSource('File',source_tbl_data_source.Name,source_tbl_data_source.FilePath,None))
            elif (type(source_tbl_data_source).__name__  == "StdfFileDataSource"):
                if not source_tbl_data_source.DataOriginIsStream:
                    tbl_file_list.append(FileDataSource('STDF',source_tbl_data_source.Name,source_tbl_data_source.FilePath,None))
            elif (type(source_tbl_data_source).__name__  == "SbdfFileDataSource"):
                if not source_tbl_data_source.DataOriginIsStream:
                    tbl_file_list.append(FileDataSource('SBDF',source_tbl_data_source.Name,source_tbl_data_source.FilePath,None))
            else:
                print 'Data source is not supported. Type = ' + type(source_tbl_data_source).__name__
        elif type(data_operation).__name__ == 'DataTableDataSourceOperation' and data_operation.DataTable is not None:
            source_table_name = get_name_in_report(data_operation.DataTable.Name)
            if data_operation.DataTable.Name is not None:
                if data_operation.DataTable.Name not in report_table_list:
                   report_table_list_json.append(data_operation.DataTable.Name)
                tbl_data_source_obj_List.append(TableDataSource(source_table_name, str(data_operation.UpdateBehavior),None ))
        elif (type(data_operation).__name__ == 'AddRowsOperation' or type(data_operation).__name__ == 'AddColumnsOperation' ):
            tbl_data_source_obj_List.append(TableDataSource(source_table_name, 'Automatic',get_table_operations(data_operation)))

    return TableSource(tbl_data_source_obj_List, tbl_conn_obj_list, tbl_il_list, tbl_file_list)


def get_table_operations(data_operation):
    '''
    Retrieves table operations. 
    Supported operations are AddColumns and AddRows operations
    Arguments:
        data_operation {Object} -- data operation object

    Returns:
        TableOperations {Class} -- table operations class and its' parameters
        
    '''
    tbl_add_col_list = []
    tbl_add_row_list = []

    if type(data_operation).__name__ == 'AddColumnsOperation':
        col_map = {}
        ignored_columns=[]
        for col in data_operation.AddColumnsSettings.IgnoredColumns:
            ignored_columns.append(str(col))
        for m in data_operation.AddColumnsSettings.Map:
            col_map.Add(str(m.Key), str(m.Value))
        add_column_op_dict = {
            'treat_empty_values_as_equal':data_operation.AddColumnsSettings.TreatEmptyValuesAsEqual,
            'data_loading_behavior':str(data_operation.DataLoadingBehavior),
            'join_type':str(data_operation.AddColumnsSettings.JoinType),
            'ignored_columns':ignored_columns,
            'col_map':col_map
        }
        tbl_add_col_list.append(AddColumnOperation(add_column_op_dict))

    if type(data_operation).__name__ == 'AddRowsOperation':
        col_map = {}
        ignored_columns=[]

        for col in data_operation.AddRowsSettings.IgnoredColumns:
            ignored_columns.append(str(col))
        for m in data_operation.AddRowsSettings.Map:
            col_map.Add(str(m.Key), str(m.Value))
        add_rows_op_dict = {
            'create_new_source_column':data_operation.AddRowsSettings.CreateNewSourceColumn,
            'new_row_source_value':data_operation.AddRowsSettings.NewRowSourceValue,
            'original_row_source_value':data_operation.AddRowsSettings.OriginalRowSourceValue,
            'row_source_column_name':data_operation.AddRowsSettings.RowSourceColumnName,
            'use_existing_source_column':data_operation.AddRowsSettings.UseExistingSourceColumn,
            'ignored_columns':ignored_columns,
            'col_map':col_map
        }
        tbl_add_row_list.append(AddRowOperation(add_rows_op_dict))

    return TableOperations(tbl_add_col_list, tbl_add_row_list, None,None)


def get_table_transformations(table_obj):
    '''
    Retrieves table transformations. 
    Supported operations are Pivot and Unpivot transformations
    Arguments:
        table_obj {Object} -- table object

    Returns:
        TableTransformations {Class} -- table transformations class and its' parameters
        
    '''
    tbl_pivot_list = []
    tbl_unpivot_list = []
    tbl_change_col_list = []
    tbl_change_col_name_list = []
    tbl_replace_spec_val_list = []
    tbl_exclude_col_list = []
    tbl_filter_rows_list = []
    source_view = table_obj.GenerateSourceView()
    for operation in source_view.OperationsSupportingTransformations:
        rename_col_list = []
        exclude_col_list = []
        change_col_list= []
        for transformation in operation.GetTransformations():
            if transformation.Name=='Pivot':
                tbl_pivot_list.append(PivotTransformation(get_pivot_transormation_paramaters(transformation)))
            elif transformation.Name=='Unpivot':
                tbl_unpivot_list.append(UnpivotTransformation(get_pivot_transormation_paramaters(transformation)))
            elif transformation.Name=='Change data types' or transformation.Name=='Calculate and replace column' or transformation.Name=='Replace value':
                for item in (transformation.AsExpressionTransformation().ColumnReplacements.GetEnumerator() ):
                    for col in item.ColumnSelection.DataColumnSignatures:
                        change_col_list.append(col.Name)
                    tbl_change_col_list.append(ChangeColumnTransformation(transformation.Name, change_col_list,item.ColumnNameExpression,item.Expression))
            elif transformation.Name=='Change column names':
                for col in transformation.ColumnsToRename:
                    rename_col_list.append(col.Name)
                tbl_change_col_name_list.append(ChangeColumnNameTransformation(rename_col_list,transformation.ColumnNameExpression))
            elif transformation.Name=='Exclude columns':
                for col in transformation.ColumnsToExclude:
                    exclude_col_list.append(col.Name)
                tbl_exclude_col_list.append(ExcludeColumnTransformation(exclude_col_list))
            elif transformation.Name=='Replace specific value':
                tbl_replace_spec_val_list.append(ReplaceSpecificValueTransformation(replace_specific_value_transformation(transformation)))
            elif transformation.Name=='Filter rows':
                tbl_filter_rows_list.append(FilterRowsTransformation(transformation.AsExpressionTransformation().WhereClause))
            
        table_transormations_obj_dict = {
            'pivot_list':tbl_pivot_list,
            'unpivot_list':tbl_unpivot_list,
            'change_col_list':tbl_change_col_list,
            'change_col_name_list':tbl_change_col_name_list,
            'exclude_col_list':tbl_exclude_col_list,
            'replace_spec_val_list':tbl_replace_spec_val_list,
            'filter_rows_list':tbl_filter_rows_list
        }

    return TableTransformations(table_transormations_obj_dict)


def get_unpivot_transormation_paramaters(transformation):
    '''
    Creates a dictionary of all paramaters used in pivot transformation. 
    Arguments:
        transformation {Object} -- transformation object
    Returns:
        pivot_op_obj_dict {Dictionary} -- dict of paramaters for pivot transformation
    '''
    id_col_list = []
    val_col_list = []
    category_name = transformation.CategoryName
    category_type = transformation.CategoryType.Name
    result_name = transformation.ResultName
    result_type = transformation.ResultType.Name
    for a in transformation.IdentityColumns:
        id_col_list.append(a.Name)
    for a in  transformation.ValueColumns:
        val_col_list.append(a.Name)
    unpivot_op_obj_dict = {
        'category_name':category_name,
        'category_type':category_type,
        'result_name':result_name,
        'result_type':result_type,
        'id_col_list':id_col_list,
        'val_col_list':val_col_list
    }
    return unpivot_op_obj_dict


def get_pivot_transormation_paramaters(transformation):
    '''
    Creates a dictionary of all paramaters used in unpivot transformation. 
    Arguments:
        transformation {Object} -- transformation object
    Returns:
        unpivot_op_obj_dict {Dictionary} -- dict of paramaters for unpivot transformation
    '''
    tmp_list = []
    pivot_col_list = []
    id_col_list = []
    transfer_col_dict = {}
    val_col_dict = {}
    for i in transformation.CategoryColumns or []:
        pivot_col_list.append(i.Name)
    for a in transformation.IdentityColumns or []:
        id_col_list.append(a.Name)
    for a in transformation.TransferColumns or []:
        transfer_col_dict[a.Aggregation] =  a.Column.Name
    for a in  transformation.ValueColumns or []:
        tmp_list.append(a.Column.Name)
    val_col_dict[a.Aggregation]= tmp_list
    pivot_op_obj_dict = {
        'category_separator':transformation.CategorySeparator,
        'result_name_expression':transformation.ResultNamingExpression,
        'transfer_naming_expression':transformation.TransferNamingExpression,
        'pivot_col_list':pivot_col_list,
        'id_col_list':id_col_list,
        'transfer_col_dict':transfer_col_dict,
        'val_col_dict':val_col_dict
    }
    return pivot_op_obj_dict


def replace_specific_value_transformation(transformation):
    '''
    Creates a dictionary of all paramaters used in replace values transformation. 
    Arguments:
        transformation {Object} -- transformation object
    Returns:
        replace_spec_val_obj_dict {Dictionary} -- dict of paramaters for replace values transformation
    '''
    row_identifying_cols = []
    row_identifying_col_vals = []
    for i in transformation.RowIdentifyingColumnSignatures:
        row_identifying_cols.append(i.Name)
    for i in transformation.RowIdentifyingColumnValues:
        row_identifying_col_vals.append(i)
    replace_spec_val_obj_dict = {
        'column_name':transformation.Column.Name,
        'original_value':transformation.OriginalValue,
        'new_value':transformation.NewValue,
        'row_identifying_cols':row_identifying_cols,
        'row_identifying_col_vals':row_identifying_col_vals,
        'warn_when_replacing_mult_vals':transformation.WarnWhenReplacingMultipleValues
    }
    return replace_spec_val_obj_dict


def get_column_operations(table_obj):
    '''
    Retrieves data table column operations like Calculated/Hierarchy/Binned/FreezeCol

    Arguments:
        table_obj {Object} -- table object

    Returns:
        TableColumnOperations {Class} -- table column operations class and its' parameters
        
    '''

    tbl_calc_col_list = [] 
    tbl_hierarchy_col_list = []
    tbl_binned_col_list = []
    tbl_frozen_col_list = []
    
    for column in table_obj.Columns:
        if column.Properties.ColumnType==DataColumnType.Calculated: 
            tbl_calc_col_list.append(CalculatedColumns(column.Name,column.Properties.Expression))
        elif column.Properties.ColumnType==DataColumnType.Hierarchy: 
            expressions = []
            for i in column.As[HierarchyColumn]().HierarchyDefinition.LevelExpressions:
                expressions.append(i)
            tbl_hierarchy_col_list.append(HierarchyColumns(column.Name,str(column.As[HierarchyColumn]().HierarchyDefinition.NestingMode),expressions))
        elif column.Properties.ColumnType==DataColumnType.Binned:
            tbl_binned_col_list.append(BinnedColumns(column.Name,column.Properties.Expression))
        elif column.Properties.ColumnType==DataColumnType.Frozen:
            tbl_frozen_col_list.append(FrozenColumns(column.Name))
    return TableColumnOperations(tbl_calc_col_list,tbl_hierarchy_col_list,tbl_binned_col_list,tbl_frozen_col_list)


def modify_doc_prop_name(table_name,report_name_flag):
    '''Modifies temporary document property name. Comment part of sql stored in this doc property and used to populate user selected values to edit panel.
    Arguments:
        table_name {String} -- data table name by which temporary doc property will be named after
        report_name_flag {Boolen} -- flag to identify if report name included in the table name
    Returns:
        modified_doc_prop_name {String} -- modified doc property name. Modification required as Spotfire doesn't allow to have special characters in doc property name
    '''
    if report_name_flag == True:
        modified_doc_prop_name = table_name.split(":")[1].replace("pm_","").replace("_","underscore").replace("(","leftbracket").replace(")","rightbracket").replace(" ","space")
    else:
        modified_doc_prop_name = table_name.replace("_","underscore").replace("(","leftbracket").replace(")","rightbracket").replace(" ","space")
    
    return modified_doc_prop_name


def clean_up(current_report_name):
    """
    Performs clean-up procedures that includes deleteting generated data tables and reseting doc properties values after report saved

    Arguments:
        current_report_name {String} -- name of the current report
   
    """
    
    if not current_report_name == '':
        if str(selected_report) != 'None':
            for table in Document.Data.Tables:
                if table.Name.startswith('pm_') or table.Name.startswith('DC_') or table.Name.startswith(report_name) or table.Name.startswith(selected_report):
                    if ':' in table.Name:
                        modified_doc_prop_name = modify_doc_prop_name(table.Name, True)
                        if (Document.Data.Properties.ContainsProperty(DataPropertyClass.Document, modified_doc_prop_name)):
                            attr = DataProperty.DefaultAttributes
                            prop = DataProperty.CreateCustomPrototype(modified_doc_prop_name, DataType.String, attr)
                            Document.Data.Properties.RemoveProperty(DataPropertyClass.Document, prop)
                        Document.Data.Tables.Remove(table)
                    else:
                        modified_doc_prop_name = modify_doc_prop_name(table.Name, False)
                        if (Document.Data.Properties.ContainsProperty(DataPropertyClass.Document, modified_doc_prop_name)):
                            attr = DataProperty.DefaultAttributes
                            prop = DataProperty.CreateCustomPrototype(modified_doc_prop_name, DataType.String, attr)
                            Document.Data.Properties.RemoveProperty(DataPropertyClass.Document, prop)
                        Document.Data.Tables.Remove(table)
        else:
            for table in Document.Data.Tables:
                if table.Name.startswith('pm_') or table.Name.startswith('DC_') or table.Name.startswith(report_name):
                    modified_doc_prop_name = modify_doc_prop_name(table.Name, False)
                    if (Document.Data.Properties.ContainsProperty(DataPropertyClass.Document, modified_doc_prop_name)):
                        attr = DataProperty.DefaultAttributes
                        prop = DataProperty.CreateCustomPrototype(modified_doc_prop_name, DataType.String, attr)
                        Document.Data.Properties.RemoveProperty(DataPropertyClass.Document, prop)
                    Document.Data.Tables.Remove(table)

        for prop in Document.Data.Properties.GetProperties(DataPropertyClass.Document):
            if "DCunderscore" in prop.Name:
               Document.Data.Properties.RemoveProperty(DataPropertyClass.Document, prop)

        if str(selected_report) != 'None':
            for page in Document.Pages:
                if page.Title.startswith('pm_') or page.Title.startswith(report_name) or page.Title.startswith(selected_report) or page.Title not in pmex_page_list:
                    Document.Pages.Remove(page)
        else:
            for page in Document.Pages:
                if page.Title.startswith('pm_') or page.Title.startswith(report_name) or page.Title not in pmex_page_list:
                    Document.Pages.Remove(page)

    Document.Data.Tables['PageReportMap'].RemoveRows(RowSelection(IndexSet(Document.Data.Tables['PageReportMap'].RowCount,True)))

    Document.Properties['ActiveReportInEditMode'] = ''  
    Document.Properties['ReportName'] = ''
    Document.Properties['ReportDescription'] = ''
    Document.Properties['SelectedDataTableList'] = ''
    Document.Properties['SelectedGraphList'] = ''
    Document.Properties['saveReportErrorMsg'] = ''
    Document.Properties["Mode"] = ''
    Document.Properties["ReportNameExists"] = False

    measure_mapping_selected_dt.RemoveRows(RowSelection(IndexSet(measure_mapping_selected_dt.RowCount,True)))
    Document.Properties['SystemAreaTopology'] = 'Core'
    measure_mapping_all_dt = Document.Data.Tables['Measure Mapping']
    marking=Application.GetService[DataManager]().Markings['Measures']
    select_rows = IndexSet(measure_mapping_all_dt.RowCount, False)
    marking.SetSelection(RowSelection(select_rows),measure_mapping_all_dt)
    Document.Properties['timeSelector'] = 'precedingPeriod'
    Document.Properties['AggregationSelection'] = 'RAW'
    Document.Properties['precedingPeriods'] = 2
    Document.Properties['precedingPeriodsUnits'] = 'Hour(s)'
    Document.Properties['NodeOrCollection'] = 'NODE'
    Document.Properties['ObjectAggregation'] = 'No Aggregation'
    Document.Properties['SystemAreaInReport'] = ''
    Document.Properties['UpdateAllPages'] = False
    Document.Properties['ColonFlag'] = False
    page_report_map_dt.RemoveRows(RowSelection(IndexSet(page_report_map_dt.RowCount,True)))

    for page in Document.Pages:
        if (page.Title == "Measure Selection"):
            filter_panel = page.FilterPanel
            for table_group in filter_panel.TableGroups:
                for fh in table_group.FilterHandles:
                    if fh.Visible:
                        if (fh.FilterReference.TypeId == FilterTypeIdentifiers.CheckBoxFilter):
                            cb_filter = fh.FilterReference.As[filters.CheckBoxFilter]()
                            for checked_values in cb_filter.Values:
                                cb_filter.Check(checked_values)

    for page in Document.Pages:
        if (page.Title == "Measure Selection"):
            filter_panel = page.FilterPanel
            measure_filter= filter_panel.TableGroups[7].GetFilter("Measure")
            text_filter = measure_filter.FilterReference.As[filters.TextFilter]()
            text_filter.Reset()


def get_list_of_tables_used_in_current_analysis(report_name):
    table_list= [] 
    for page in Document.Pages:
        if page.Title not in pmex_page_list:
            for visual in page.Visuals:
                if visual.Title not in visual_titles_exceptions:
                    visualization = visual.As[Visualization]()
                    referenced_table_name = visualization.Data.DataTableReference.Name
                    if referenced_table_name not in pmex_table_list and not referenced_table_name.startswith('DC_') and not referenced_table_name.startswith('DIM_'):
                        if referenced_table_name.startswith('pm_') or referenced_table_name.startswith(report_name) or referenced_table_name.startswith(selected_report):
                            if ':' in referenced_table_name:
                                if not referenced_table_name.split(':')[1].startswith('DC_'):
                                    if referenced_table_name.split(':')[1] not in table_list:
                                        table_list.append(referenced_table_name.split(':')[1])
                            else:
                                if referenced_table_name not in table_list:
                                    table_list.append(referenced_table_name)

    return table_list


#Get user input
report_name = Document.Properties['ReportName']
selected_report = Document.Properties['SelectedReport']
if str(selected_report) == 'None':
    selected_report = 'None'
report_description = Document.Properties['ReportDescription']
report_access_type = Document.Properties['ReportAccessType']
mode = Document.Properties['Mode']
report_table_list = get_list_of_tables_used_in_current_analysis(report_name)
report_graph_list = get_list_of_graphs_in_current_analysis() 
SavedReportColumn = SavedReportColumn()
savedReportColumns = [SavedReportColumn.ReportName, SavedReportColumn.ReportDescription, SavedReportColumn.ReportAccess]

get_report_details(report_name, report_description, report_access_type)