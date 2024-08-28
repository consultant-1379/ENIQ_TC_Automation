from pywinauto import Application
import time
from pywinauto_recorder.player import *

app=Application().start(r'C:\Program Files (x86)\SAP BusinessObjects\SAP BusinessObjects Enterprise XI 4.0\win64_x64\designer.exe').connect(title="User Identification", class_name="#32770")
app.UserIdentification.Edit0.set_edit_text(u'')
app.UserIdentification.Edit0.type_keys('atclvm887:6400')
app.UserIdentification.Edit2.set_edit_text(u'')
app.UserIdentification.Edit2.type_keys('Administrator')
app.UserIdentification.Edit3.type_keys('Shroot12')
app.UserIdentification.Button1.click()
server='@ATCLVM887:6400'
pkg="TP Ericsson AFG PM_R20_b11"
with UIPath(f"Universe Design Tool - [Administrator - {server}]||Window"):
        a=app[f"Universe Design Tool - [Administrator - {server}"]
        with UIPath(f'Menu Bar||ToolBar'):
            click(f"File||MenuItem")
with UIPath(f"Context||Menu"):
          click(f"||MenuItem#[6,0]") 
with UIPath(f"Import Universe||Window"):
         b=app[f"Import Universe"]
         print(b.print_control_identifiers())
         b.Static3.click()
        
         #c.child_window(title="<Universes on 10.59.140.44:6400>", class_name="ComboBox").click()
        #browser button
        # b.Button5.click()
        
#with UIPath(u"Select a Universe Folder||Window"):
#           e=app[u"Select a Universe Folder"]
# #          f=e.child_window(class_name="BOTreeList")
#           e.CancelButton.click()
         
        #   scrollbar=b.child_window(class_name="ScrollBar")
        #   b.ListView.select(4)
        #   scrollbar.ScrollDown()
          
#          b.OKButton.click()
#          time.sleep(99)
#          # * * *  import **
#          with UIPath(u"Import Universe||Window"):
#              c=app[u"Import Universe"]
#              #print(c.print_control_identifiers())
#              conn=c.child_window(title="Universe successfully imported.", class_name="Static").Texts()
#              if "Universe successfully imported." in conn:
#                      print("Universe successfully imported")
#              else:
#                     print("Universe not successfully imported ") 
#              c.OKButton.click()
#              with UIPath(u"Designer||Window"):
#                   d=app[u"Designer"]
#                   #print(d.print_control_identifiers())
#                   d.OKButton.click()

#      # click on parameter  
# with UIPath(f"Universe Design Tool - {pkg.split('_R')[0]} - [Administrator - {server}]||Window"):
#        # k=app[u"Universe Design Tool - {pkg.split('_R')[0]} - [Administrator - {server}]"]      
#         with UIPath(u'Menu Bar||ToolBar'):
            
#              click(u"File||MenuItem")
# with UIPath(u"Context||Menu"):
#          click(u"||MenuItem#[8,0]")  
#          time.sleep(5)
# with UIPath(u"Universe parameters||Window"): 
#      up=app[u"Universe parameters"] 
#      up.Button.click()
#      with UIPath(u"Define a new connection||Window"):
#         connection=app[u"Define a new connection"]
#         click(u"Secured||ComboBox")
#         click(u"Connection Name:||Edit").type_keys("server")
#         click(u"Next >||Button")

         

        
         
         
         
