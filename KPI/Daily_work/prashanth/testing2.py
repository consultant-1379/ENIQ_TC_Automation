from pywinauto import Application
import time
from pywinauto_recorder.player import *

app=Application(backend='win32').start(r'C:\Program Files (x86)\SAP BusinessObjects\SAP BusinessObjects Enterprise XI 4.0\win64_x64\designer.exe').connect(title="User Identification", class_name="#32770")
app.UserIdentification.Edit0.set_edit_text(u'')
app.UserIdentification.Edit0.type_keys('atclvm887:6400')
app.UserIdentification.Edit2.set_edit_text(u'')
app.UserIdentification.Edit2.type_keys('Administrator')
app.UserIdentification.Edit3.type_keys('Shroot12')
app.UserIdentification.Button1.click()
server="@ATCLVM887:6400"
pkg="TP Ericsson AFG PM"
with UIPath(f"Universe Design Tool - [Administrator - {server}]||Window"):
       # a=app[f"Universe Design Tool - [Administrator - {server}"]
        with UIPath(u'Menu Bar||ToolBar'):
                click(u"File||MenuItem")
with UIPath(u"Context||Menu"):
        click(u"||MenuItem#[6,0]") 
        
with UIPath(u"Import Universe||Window"):
        b=app[u"Import Universe"]
        b.OKButton.click()
        time.sleep(99)
        with UIPath(u"Import Universe||Window"):
             c=app[u"Import Universe"]
             conn=c.child_window(title="Universe successfully imported.", class_name="Static").Texts()
             if "Universe successfully imported." in conn:
                     print("Universe successfully imported")
                     c.OKButton.click()
             else:
                    print("Universe not imported ") 
with UIPath(u"Designer||Window"):
                  d=app[u"Designer"]
                  #print(d.print_control_identifiers())
                  d.OKButton.click()
         
with UIPath(f"Universe Design Tool - {pkg} - [Administrator - {server}]||Window"):
        k=app[f"Universe Design Tool - {pkg} - [Administrator - {server}]"]      
        with UIPath(u'Menu Bar||ToolBar'):
             click(u"File||MenuItem")
             time.sleep(10)
with UIPath(u"Context||Menu"):
         click(u"||MenuItem#[8,0]")  
         time.sleep(10)
with UIPath(u"Universe parameters||Window"): 
     parameter=app[u"Universe parameters"] 
     para=parameter.print_control_identifiers()
     parameter.NewButton.click()
     with UIPath(u"Define a new connection||Window"):
        connection=app[u"Define a new connection"]
        click(u"Secured||ComboBox")
        click(u"Connection Name:||Edit").type_keys("server")
        click(u"Next >||Button")
        connection.List.select(18)
        click(u"Next >||Button")
       # connection.
