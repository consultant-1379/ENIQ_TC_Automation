def compare(a_db,b_xml):
    z="".join(a_db.split("\n")[1:][:-2])
    d_db=z.strip()
    if b_xml in d_db:
        return "AssociatedRNC tag present and RNC_ID is validated from database and xml. "

def compare1(b1,db):
    b1_xml=str(b1.replace("[",""))
    b1_xml=str(b1_xml.replace("]",""))
    b1_xml=str(b1_xml.replace(' ',''))
    print(b1_xml)
    res = list(map(lambda x: str(x), b1_xml.split(',')))
    index=0
    for i in res:
        if(i.startswith('MeContext')):
            index=res.index(i)
            print(index,i)
    
            inde=index-1
            sub=res.__getitem__(inde)
            status=sub.split('=')[-1]
            print(status)
            x = status.startswith("ONRM")
            y = status.startswith("SubNetwork")
            if x==False and y==False:
                if status in db:
                    return "AssociatedRNC tag not present and RNC_ID is validated just previous to subnetwork of MeContext from database and xml. "
            else:
                if x == True or y==True:                    
                    if " " in db:
                        return "RNC_ID KEY should not load if only default SubNetwork=SubNetwork or SubNetwork=ONRM* is coming along with MeContext in FDN. "


            


                

                

 
  



    
    
    