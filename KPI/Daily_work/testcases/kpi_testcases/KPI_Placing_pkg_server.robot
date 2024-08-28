*** Settings ***
Library    H:\\Desktop\\robo\\testcases\\tp.py
*** Variables ***
${package} =     'DC_E_CCRC_R9A_b16.tpi'
${server} =     '4100'
*** Tasks ***
Package placing
    File Transfer    ${package}    ${server}  