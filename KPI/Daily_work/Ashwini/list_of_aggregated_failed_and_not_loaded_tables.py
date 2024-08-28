import re
def     list_of_aggregated_tables(output):
    # flag=True
    # failed_tables=[]
    # not_loaded=[]
    valueone = output.replace(' ',"")
    valuetwo= valueone.replace('\r\n',"")
    valuethree= re.sub(r"(eniq\S*\s*\S*\s*\S*\s*\S*-b)",'',valuetwo)
    valuefour= re.findall("DC\S*\s*\S*\s*DAY",valuethree)
    lst_aggregated=[re.sub('\t',' ',i) for i in valuefour if 'AGGREGATED' in i]
    return(lst_aggregated)
def     aggregated_tables(output):
    str= " "
    return(str.join(output))
def     list_of_failed_dependency_tables(output):
    # flag=True
    # failed_tables=[]
    # not_loaded=[]
    valueone = output.replace(' ',"")
    valuetwo= valueone.replace('\r\n',"")
    valuethree= re.sub(r"(eniq\S*\s*\S*\s*\S*\s*\S*-b)",'',valuetwo)
    valuefour= re.findall("DC\S*\s*\S*\s*DAY",valuethree)
    lst_failed= [re.sub('\t',' ',i) for i in valuefour if 'FAILEDDEPENDENCY' in i]
    # return(str.join(lst_failed))
    return(lst_failed)
def     failed_tables_str_conversion(output):
    str = " "
    return(str.join(output))
def     list_of_not_loaded_tables(output):
    # flag=True
    # failed_tables=[]
    # not_loaded=[]
    valueone = output.replace(' ',"")
    valuetwo= valueone.replace('\r\n',"")
    valuethree= re.sub(r"(eniq\S*\s*\S*\s*\S*\s*\S*-b)",'',valuetwo)
    valuefour= re.findall("DC\S*\s*\S*\s*DAY",valuethree)
    lst_not_loaded=[re.sub('\t',' ',i) for i in valuefour if 'NOT_LOADED' in i]
    return(lst_not_loaded)
def     not_loaded_tables(output):
    str= " "
    return(str.join(output))