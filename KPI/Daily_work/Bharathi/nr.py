def fromdb(a,b):
    y=str(a)
    c_xml = sum(b, [])
    z="".join(y.split("\n")[1:][:-2])
    d=z.strip()
    d = d.replace('    ', ' ')
    b_db = list(map(lambda x: int(x), d.split()))
    c_xml=[int(x) for x in c_xml]
    flag=False
    for i in b_db:
        if i in c_xml:
            print(i)
            flag=True
        else:
            flag=False
    if flag==True:
        return "Validated the key values of mcc and mnc from DB and XML"
    else:
        return "Failed to Validate the key values of mcc and mnc from DB and XML"
    

