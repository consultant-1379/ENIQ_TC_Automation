*** Settings ***
Library        .\\Scripts\\IDT.py

*** Test Cases ***
IDT APP VERIFY
    ${out}    IDT
    Should Contain  ${out}    true1