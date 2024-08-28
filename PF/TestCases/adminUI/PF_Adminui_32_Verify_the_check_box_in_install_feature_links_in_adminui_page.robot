*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify check box in install feature links in adminui page
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Install Features
	${is_Feature_installation_required}=    Verify the Install features available
    Sleep    2s
	IF    ${is_Feature_installation_required} == True
	    Selecting the features
        Sleep    3s
        Click on scroll down
        Enter root password    ${Eniq-s password}   ${root password}
        Click on button    Install
        #Increase the sleep time as for feature selected
        Sleep    35min
        Vaildating the AdminUI page    Feature Installation Overview - INSTALLATION SUCCESSFUL
        Vaildating the AdminUI page    COMPLETED
        Enter root password    commitpassword       ${root password}    
        Click on button    ${commit button}    
        Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
        Sleep    2min
        Vaildating the AdminUI page    This site can’t be reached
        Sleep    5min
        Reload Page
        Verify the Adminui Login page is displayed    
        Logout from Adminui
	END
	${is_features_already_installed}=    Verify the Install Features not available    
	Skip If    $is_features_already_installed    No Features to install.Test was skipped
	Logout from Adminui
       

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser


    

    


	
