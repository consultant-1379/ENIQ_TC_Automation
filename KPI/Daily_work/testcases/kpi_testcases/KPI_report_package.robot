*** Settings ***
Library           RPA.Browser.Selenium
Library           Dialogs

*** Variables ***
${url}            https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/Report_Package/
${username}       zanissu
*** Test Cases ***
Opening Nexus Repo for getting latest Report_Package
    Open Available Browser    ${url}
    Maximize Browser Window
    ${title}=    Get Window Titles
    # IF    ${title} == ['Access Denied']
    login into Nexus
    # ELSE
        # Log    Failure
    # END
    # Click Element When Visible    //a[text()='Repositories']
    # Click Element When Visible    //*[@id="ext-gen347"]/div[3]/table/tbody/tr/td[7]/div/a
    # Click Element When Visible    //a[text()='Parent Directory']

    Execute Javascript   window.open('https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/Report_Package/')
    Pause Execution    10
*** Keywords ***
login into Nexus
    Click Link    //p/a   
    ${password}=    Get Value From User    Enter Password    hidden=yes
    Input Text    //input[@name='username']    ${username}
    Input Password    //input[@name='password']    ${password}
    Click Button    //button[text()='Log In']