*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource        ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test disable SR parameters values are not 0 - Negative scenario

    ${file_existence}=        Execute Command          test -f /etc/sysctl.conf && echo "Success" || echo "Fail"
    Should Be Equal           ${file_existence}        Success
    Log To Console            \nConfig file is present\n
    Execute Command           cp /etc/sysctl.conf /root/sysctl_backup.conf
    Log To Console            \nSuccessfully backed up config file.\n
    Execute Command           sed -i 's/net.ipv4.conf.all.send_redirects=0/net.ipv4.conf.all.send_redirects=1/g; s/net.ipv4.conf.default.send_redirects=0/net.ipv4.conf.default.send_redirects=1/g; s/net.ipv4.conf.all.accept_redirects=0/net.ipv4.conf.all.accept_redirects=1/g; s/net.ipv4.conf.default.accept_redirects=0/net.ipv4.conf.default.accept_redirects=1/g; s/net.ipv4.conf.all.accept_source_route=0/net.ipv4.conf.all.accept_source_route=1/g; s/net.ipv4.conf.default.accept_source_route=0/net.ipv4.conf.default.accept_source_route=1/g' /root/sysctl_backup.conf
    Log To Console            Negative Scenario contents are written to backup file
    ${negative_expected}       Execute Command         grep  -e "net.ipv4.conf.all.send_redirects" -e "net.ipv4.conf.default.send_redirects" -e "net.ipv4.conf.all.accept_redirects" -e "net.ipv4.conf.default.accept_redirects" -e "net.ipv4.conf.all.accept_source_route" -e "net.ipv4.conf.default.accept_source_route" /root/sysctl_backup.conf
    Should Not Contain         ${negative_expected}        net.ipv4.conf.all.send_redirects=0        net.ipv4.conf.default.send_redirects=0        net.ipv4.conf.all.accept_redirects=0         net.ipv4.conf.default.accept_redirects=0     net.ipv4.conf.all.accept_source_route=0        net.ipv4.conf.default.accept_source_route=0
    Log To Console            \nNegative scenario tested successfully\n
    Execute Command           rm -rf /root/sysctl_backup.conf
    Log To Console            \nBackup file deleted succssfully\n

Test disable SR parameters values are 0 - Positive scenario
    ${result}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.all.send_redirects
	${sysctl_file_check}=        Get Lines Matching Regexp    ${result}      net.ipv4.conf.all.send_redirects=0
	Should Be Equal     ${sysctl_file_check}       net.ipv4.conf.all.send_redirects=0

    ${result1}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.default.send_redirects
	${sysctl_file_check1}=        Get Lines Matching Regexp    ${result1}      net.ipv4.conf.default.send_redirects=0
	Should Be Equal     ${sysctl_file_check1}       net.ipv4.conf.default.send_redirects=0

    ${result2}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.all.accept_redirects
	${sysctl_file_check2}=        Get Lines Matching Regexp    ${result2}      net.ipv4.conf.all.accept_redirects=0
	Should Be Equal     ${sysctl_file_check2}       net.ipv4.conf.all.accept_redirects=0

    ${result3}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.default.accept_redirects
	${sysctl_file_check3}=        Get Lines Matching Regexp    ${result3}      net.ipv4.conf.default.accept_redirects=0
	Should Be Equal     ${sysctl_file_check3}       net.ipv4.conf.default.accept_redirects=0

    ${result4}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.all.accept_source_route
	${sysctl_file_check4}=        Get Lines Matching Regexp    ${result4}      net.ipv4.conf.all.accept_source_route=0
	Should Be Equal     ${sysctl_file_check4}       net.ipv4.conf.all.accept_source_route=0

    ${result5}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv4.conf.default.accept_source_route
	${sysctl_file_check5}=        Get Lines Matching Regexp    ${result5}      net.ipv4.conf.default.accept_source_route=0
	Should Be Equal     ${sysctl_file_check5}       net.ipv4.conf.default.accept_source_route=0

    ${result6}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv6.conf.all.accept_source_route
	${sysctl_file_check6}=        Get Lines Matching Regexp    ${result6}      net.ipv6.conf.all.accept_source_route=0
	Should Be Equal     ${sysctl_file_check6}       net.ipv6.conf.all.accept_source_route=0

    ${result7}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv6.conf.default.accept_source_route
	${sysctl_file_check7}=        Get Lines Matching Regexp    ${result7}      net.ipv6.conf.default.accept_source_route=0
	Should Be Equal     ${sysctl_file_check7}       net.ipv6.conf.default.accept_source_route=0

    ${result8}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv6.conf.all.accept_redirects
	${sysctl_file_check8}=        Get Lines Matching Regexp    ${result8}      net.ipv6.conf.all.accept_redirects=0
	Should Be Equal     ${sysctl_file_check8}       net.ipv6.conf.all.accept_redirects=0

    ${result9}=      Execute Command       cat /etc/sysctl.conf | grep net.ipv6.conf.default.accept_redirects
	${sysctl_file_check9}=        Get Lines Matching Regexp    ${result9}      net.ipv6.conf.default.accept_redirects=0
	Should Be Equal     ${sysctl_file_check9}       net.ipv6.conf.default.accept_redirects=0
    
Test disable SR is enforced in sysctl daemon - verifying system daemon

    ${sysctl_check1}=        Execute Command       sysctl -n net.ipv4.conf.all.send_redirects
    Should Be Equal    ${sysctl_check1}    0
    ${sysctl_check2}=        Execute Command       sysctl -n net.ipv4.conf.default.send_redirects
    Should Be Equal    ${sysctl_check2}    0    
    ${sysctl_check3}=        Execute Command       sysctl -n net.ipv4.conf.all.accept_redirects
    Should Be Equal    ${sysctl_check3}    0
    ${sysctl_check4}=        Execute Command       sysctl -n net.ipv4.conf.default.accept_redirects
    Should Be Equal    ${sysctl_check4}    0
    ${sysctl_check5}=        Execute Command       sysctl -n net.ipv4.conf.all.accept_source_route
    Should Be Equal    ${sysctl_check5}    0
    ${sysctl_check6}=        Execute Command       sysctl -n net.ipv4.conf.default.accept_source_route
    Should Be Equal    ${sysctl_check6}    0
    ${sysctl_check7}=        Execute Command       sysctl -n net.ipv6.conf.all.accept_source_route
    Should Be Equal    ${sysctl_check7}    0
    ${sysctl_check8}=        Execute Command       sysctl -n net.ipv6.conf.default.accept_source_route
    Should Be Equal    ${sysctl_check8}    0
    ${sysctl_check9}=        Execute Command       sysctl -n net.ipv6.conf.all.accept_redirects
    Should Be Equal    ${sysctl_check9}    0
    ${sysctl_check10}=        Execute Command       sysctl -n net.ipv6.conf.default.accept_redirects
    Should Be Equal    ${sysctl_check10}    0
