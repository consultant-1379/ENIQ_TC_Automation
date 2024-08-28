*** Settings ***
Library    RPA.Browser.Selenium
Library    Dialogs
Library    String
Library    OperatingSystem
Library    Collections
Library    RPA.Desktop.Windows
Library    RPA.Netsuite
Library    RPA.Robocloud.Items
Library    XML
Library    RPA.Robocorp.Process
Library    SSHLibrary
Library    Process
Library    SikuliLibrary
Library    RPA.Dialogs

#Test Setup          Open Connection And Log In
#Test Teardown    Close All Connections


*** Variables ***
${clearcase}    https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel 
${nexus}   https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/kpi
${p}    ERIC_SBG_Basic_Report_Package    
${package}    '${p}'  
${locator} 
${host}                         atvts4095.athtem.eei.ericsson.se
${port}                         2251
${uname}                        dcuser
${pwd}                          Dcuser%12
${lcmbiar}    	https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/content/repositories/releases/com/ericsson/eniq/stats/tp/TP_KPI_Script/
${script}    LCMBIAR_script
${eridoc}      https://eridoc.internal.ericsson.com/eridoc/#d2


*** Test Cases ***
Testcase 1
    Open Clearcase and Download latest package file

Testcase 2
    Open nexus and Download lastest report package file


Testcase 3
    Get Lcmbair file output


Testcase 4
    #Open Connection And Log In
    #Place the report package on server
    #Extract the report package

Testcase 5
    #Download and unzip lcmbiar script

Testcase 6
    Put all in a folder and Execute

Testcase 7
    Login eridoc
    
 

*** Keywords ***
Open Clearcase and Download latest package file
    ${user}     Get Environment Variable    username
    Set Download Directory    H:\\Downloads\\report_package
    Open Available Browser    ${clearcase}    
    Maximize Browser Window        
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    Click Link    xpath=//body//tr[last()-1]//td[2]//a   
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html 
    ${name}    Get Element Attribute    xpath=//a[text()='${p}']    href
    ${n}    Fetch From Right    ${name}    /
    Click Link    xpath=//a[text()='${p}'] 
    Wait Until Created    H:\\Downloads\\report_package\\${n} 
    
Open nexus and Download lastest report package file
    ${user}     Get Environment Variable    username
    Set Download Directory    H:\\Downloads\\report_package
    Open Available Browser    ${clearcase}    headless=True
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
    ${rstate}    RPA.Browser.Selenium.Get Text   //table//a[text()=${package}]/../following-sibling::td[3]
    Log To Console    ${\n}R-State of ${Package} is = ${rstate}  
    Open Available Browser    ${nexus}    
    Maximize Browser Window 
    ${name}    Catenate    SEPARATOR=    ${p}    _    ${rstate}    .zip 
    ${urlNexus}    Catenate    SEPARATOR=/    ${nexus}    ${p}    ${rstate}    ${name}  
    Go To    ${urlNexus} 
  
                 

        
      
Get Lcmbair file output
    ${user}     Get Environment Variable    username
    Set Download Directory    H:\\Downloads\\report_package
    Open Available Browser    ${clearcase}    #headless=True
    Click Link    //body//tr[last()-1]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${loc}    Get Location
    Go To    ${loc}SOLARIS_baseline.html
    ${rstate}    RPA.Browser.Selenium.Get Text   //table//a[text()=${package}]/../following-sibling::td[3]
    Set Global Variable    ${rstate}
    Log To Console    ${\n}R-State of ${Package} is = ${rstate} 
    ${name}    Get Element Attribute    xpath=//a[text()='${p}']    href
    ${n}    Fetch From Right    ${name}    /
    Click Link    xpath=//a[text()='${p}'] 
    Wait Until Created    H:\\Downloads\\report_package\\${n} 
    
    # Downloading previous package from vobs 
    Open Available Browser    ${clearcase}    #headless=True
    Click Link    //body//tr[last()-2]//td[2]//a
    Click Link    //body//tr[last()-1]//td[2]//a
    ${prev_loc}    Get Location
    Go To    ${prev_loc}SOLARIS_baseline.html
    ${prev_rstate}   RPA.Browser.Selenium.Get Text  //table//a[text()=${package}]/../following-sibling::td[3]
    Log To Console    ${\n}R-State of Previous ${Package} is = ${prev_rstate}  
    ${name}    Get Element Attribute    xpath=//a[text()='${p}']    href
    ${n}    Fetch From Right    ${name}    /
    Click Link    xpath=//a[text()='${p}'] 
    Wait Until Created    H:\\Downloads\\report_package\\${n} 
    ${st}    Catenate    SEPARATOR=    ${p}    _    ${rstate}
    ${str}    Catenate    SEPARATOR=    ${p}    _    ${prev_rstate}
    
           
    #Open Connection And Log In
    ${index}    Open Connection    ${host}    port=${port}    timeout=10
    Set Global Variable    ${index}
    SSHLibrary.Login  ${uname}    ${pwd}

    #Place the report package on server
    Put File    H://Downloads//report_package//${p}*    /eniq/sw/installer/BO
    
   
   #Extract the report package
   ${out}    Execute Command    cd /eniq/sw/installer && ./extract_report_packages.bsh BO boreports
   Log To Console    ${\n}${out}

    #Download and unzip lcmbiar script
    ${user}     Get Environment Variable    username
    Set Download Directory    H:\\Downloads\\report_package
    Open Available Browser    ${lcmbiar}    
    ${l}    Get Location
    Go To    ${l}${script}.zip
    Put File    H://Downloads//report_package//${script}*    /eniq/home/dcuser/lcm
    ${o}    Execute Command    cd /eniq/home/dcuser/lcm && unzip LCMBIAR_script.zip
    Log To Console    ${\n}${o}
    
Put all in a folder and Execute
    ${index}    Open Connection    ${host}    port=${port}    timeout=10
    Set Global Variable    ${index}
    SSHLibrary.Login  ${uname}    ${pwd}
    Execute Command    cd /eniq/sw/installer/boreports/ERIC_SBG_Basic_Report_Package_R16B02 
    ${c}    Execute Command    pwd
    Log To Console    ${\n}${c}
    Put File  //eniq//sw//installer//boreports//ERIC_SBG_Basic_Report_Package_R16B02//ERIC_SBG_Basic_Report_Package_R16B02.lcmbiar   /eniq/home/dcuser/LCMBIAR_script 
    Put File   //eniq//sw//installer//boreports//${str}//${str}.lcmbiar   /eniq/home/dcuser/LCMBIAR_script 
    Put File   //eniq//home//dcuser//lcm//LCMBIAR_script    /eniq/home/dcuser/LCMBIAR_script 
    

    

#/eniq/sw/installer/boreports/ERIC_SBG_Basic_Report_Package_R18A01/ERIC_SBG_Basic_Report_Package_R18A01.lcmbiar

Login eridoc
    
    ${user_name} =    Get Value From User    User name
    ${pwd} =    Get Value From User    password    hidden=True
    ${doc_num}=    Get Value From User    Document number
    #Open Available Browser    ${eridoc} 
    #Input Text    locator    text
    #Click Button    xpath=//*[@id="idSIButton9"]



    Open Available Browser    ${eridoc}  
    Maximize Browser Window     
    Set Selenium Implicit Wait  5 
    RPA.Browser.Selenium.Input Text    //*[@id="i0116"]    ${user_name} 
    Click Element   //*[@id="idSIButton9"]
    RPA.Browser.Selenium.Input Password    //*[@id="passwordInput"]    ${pwd}
    #Sleep 10
   
    Click Element   //*[@id="submitButton"]  
    Click Element    //*[@id="menuSearch-button"]
    RPA.Browser.Selenium.Input Text    //*[@id="searchText-input-input"]    ${doc_num}
    Click Element    //*[@id="x-auto-2085"]
    #Sleep 15
    

    




      
    




