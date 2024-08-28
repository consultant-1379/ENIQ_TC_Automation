*** Settings ***
Library        .\\Scripts\\UDT.py

*** Variables ***
${server_name}
${password}

*** Test Cases ***
UDT VERIFY
    ${out}    udt    ${server_name}    ${password}
    Should Contain  ${out}    Universe Design Tool 4.3