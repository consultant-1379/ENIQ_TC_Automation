def check_sprint_value(om_sw_locate):
    sprint=om_sw_locate.strip().split('/')[4]
    a,b=sprint.split('.')[0],sprint.split('.')[1]
    release=str(a)+'.'+str(b)
    if float(release)<23.4 or sprint=='23.4.8.EU1' or sprint=='23.4.8.EU2' or sprint=='23.4.8.EU3':
       return "lt"
    else:
       return "gt"
