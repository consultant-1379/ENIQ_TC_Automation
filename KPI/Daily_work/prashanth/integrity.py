from pywinauto import Application
import time
from pywinauto_recorder.player import *
from PIL import ImageGrab
def integrity_start():
    app=Application(backend='win32').start(r'C:\Program Files (x86)\SAP BusinessObjects\SAP BusinessObjects Enterprise XI 4.0\win64_x64\designer.exe').connect(title="User Identification", class_name="#32770")
    #app.UserIdentification.print_control_identifiers()
    # main_dlg=app['User Identification']

    # main_dlg.set_focus()
    # a=main_dlg.print_control_identifiers()
    # print(a)
    app.UserIdentification.Edit0.set_edit_text(u'')
    app.UserIdentification.Edit0.type_keys('atclvm887:6400')
    app.UserIdentification.Edit2.set_edit_text(u'')
    app.UserIdentification.Edit2.type_keys('Administrator')
    app.UserIdentification.Edit3.type_keys('Shroot12')
    app.UserIdentification.Button1.click()
    #time.sleep(5)
    with UIPath(u"Universe Design Tool - [Administrator - @ATCLVM887:6400]||Window"):
        a=app[u"Universe Design Tool - [Administrator - @ATCLVM887:6400"]
        
        with UIPath(u'Menu Bar||ToolBar'):
            
             click(u"File||MenuItem")
    with UIPath(u"Context||Menu"):
         click(u"||MenuItem#[12,0]") 
         time.sleep(5)
    with UIPath(u"Designer||Window"):
                  d=app[u"Designer"]
                  #print(d.print_control_identifiers())
                  d.OKButton.click()
    #TitleBar
    with UIPath(u"Universe Design Tool - TP Ericsson AFG PM - [Administrator - @ATCLVM887:6400]||Window"):
        k=app[u"Universe Design Tool - TP Ericsson AFG PM - [Administrator - @ATCLVM887:6400]"]
       # print(k.print_control_identifiers())
        # vv=k.child_window(title="Standard", class_name="ToolbarWindow32")
        # vv.child_window(name="Parameters",control_type="MenuItem").click()
        # with UIPath(u"Standard||ToolBar"):
        #       click(u"Parameters||MenuItem")

        with UIPath(u"Menu Bar||ToolBar"):
            click(u"Tools||MenuItem")
    with UIPath(u"Context||Menu"):
         click(u"||MenuItem#[8,0]")      
    
    with UIPath(u"Integrity Check||TitleBar"):
        integrity=app["Integrity Check"]
       # integrity.print_control_identifiers()
        integrity.child_window(title="Check &All", class_name="Button").click()
        integrity.child_window(title="Check &All", class_name="Button").click()
        integrity.OKButton.click()
        time.sleep(10)
    with UIPath(u"Integrity Check Results||TitleBar"):
        IntCheckResult=app["Integrity Check Results"]
        print("Integrity result page open")
        time.sleep(10)
        IntCheckResult.capture_as_image().save('integrityresult22.png')

integrity_start()