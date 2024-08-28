*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Resource           ../../../Resources/resource.txt

*** Variables ***

*** Test Cases ***
Check if dcuser home area is created
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls /eniq/home | grep dcuser
    Should Be Equal             ${output}               dcuser
	
Check if the user of repdb.cfg is dcuser
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -lrt /eniq/database/rep_main/repdb.cfg | awk '{print $3}' | grep dcuser
    Should Be Equal             ${output}               dcuser
	
Check if the permission of repdb.cfg is dc5000
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -lrt /eniq/database/rep_main/repdb.cfg | awk '{print $4}' | grep dc5000
    Should Be Equal             ${output}               dc5000
	
Check if the user of dwhdb.cfg is dcuser
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -lrt /eniq/database/dwh_main/dwhdb.cfg | awk '{print $3}' | grep dcuser
    Should Be Equal             ${output}               dcuser

Check if the permission of dwhdb.cfg is dc5000
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -lrt /eniq/database/dwh_main/dwhdb.cfg | awk '{print $4}' | grep dc5000
    Should Be Equal             ${output}               dc5000
	
Check if the group id of dcuser is dc5000
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         id dcuser | awk '{print $2}' | grep dc5000
    Should Contain              ${output}               dc5000

Checking if eniq-dwhdb service is stopped successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl stop eniq-dwhdb; systemctl show -p ActiveState eniq-dwhdb | cut -f2 -d'=' | grep inactive
    Should Be Equal             ${output}               inactive
	
Checking if eniq-dwhdb service is restarted successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl restart eniq-dwhdb; systemctl show -p ActiveState eniq-dwhdb | cut -f2 -d'=' | grep active
    Should Be Equal             ${output}               active
	
Checking if NASd.service is started successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl start NASd.service;systemctl status NASd.service | grep "active (running)"
    Should Contain              ${output}               active (running)
	
#Checking if NAS-online.service is stopped successfully
#    [Tags]                      SB
#    Set Client Configuration    timeout=25 seconds      prompt=#:
#    ${output}=                  Execute Command         systemctl stop NAS-online.service;systemctl status NAS-online.service | grep "Stopped Milestone NAS Service"
#    Should Contain           	${output}               Stopped Milestone NAS Service
	
Checking if NAS-online.service is started successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         systemctl start NAS-online.service;systemctl status NAS-online.service | grep "Started Milestone NAS Service"
    Should Contain              ${output}               Started Milestone NAS Service
	
Checking if permission of IQ Log Directory is dcuser
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/local_logs/sw_log/ | grep dcuser
    Should Contain              ${output}               dcuser
	
Checking if dcuser dir is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/home/ | grep dcuser
    Should Contain              ${output}               dcuser
	
Checking if admin dir is mounted successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/admin/ | grep bin
    Should Contain              ${output}               bin
	
Checking if smf dir is mounted successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/smf/ | grep bin
    Should Contain              ${output}               bin
	
Checking if repdb database file is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/admin/bin/ | grep repdb
    Should Contain              ${output}               repdb

Checking if sw dir is mounted successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/sw/ | grep bin
    Should Contain              ${output}               bin

Checking if webserver file is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/sw/bin/ | grep webserver
    Should Contain              ${output}               webserver

Checking if bkup_sw is mounted successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/bkup_sw/ | grep bin
    Should Contain              ${output}               bin

Checking if permission on dwhdb database is set to dcuser successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/admin/bin/dwhdb | grep dcuser
    Should Contain              ${output}               dcuser

Checking if dwh_main dir is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/database/ | grep dwh_main
    Should Contain              ${output}               dwh_main

Checking if dwh_reader dir is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/database/ | grep dwh_reader
    Should Contain              ${output}               dwh_reader

Checking if rep_main dir is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/database/ | grep rep_main
    Should Contain              ${output}               rep_main

Checking if permission on repdb database is set to dcuser successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/admin/bin/repdb | grep dcuser
    Should Contain              ${output}               dcuser

Checking if permission on webserver is set to dcuser successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/admin/bin/webserver | grep dcuser
    Should Contain              ${output}	        dcuser
	
Checking if Sentinel Licence Server is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/sentinel/lic/ | grep lservrc
    Should Contain              ${output}	        lservrc
	
Checking if all NAS directories are created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         df -hk | grep nas | wc -l
    Convert To Integer          ${output}
    ${flag}                     Set Variable            1
    IF                          ${output} < 22
    Set Variable                ${flag}                 0
    END
    Should Contain              ${flag}                 1
	
Checking if pmdata_wifi NAS dir is removed after successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         df -hk | grep -w pmdata_wifi | wc -l | grep 0
    Should Contain              ${output}	        0

Checking if ENIQ services are stopped successfully
    [Tags]                      SB
    Set Client Configuration    timeout=180 seconds     prompt=#:
    ${output}=                  Execute Command         bash /eniq/admin/bin/manage_eniq_services.bsh -a stop -s ALL -l /eniq/local_logs/autoft/auto_stop_services.log -N
    Should Contain              ${output}	        ENIQ services stopped correctly
		
Checking if stopping services log is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/local_logs/autoft/ | grep auto_stop_services.log
    Should Contain              ${output}	        auto_stop_services.log

Checking if stopping services log contains failed
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/local_logs/autoft/auto_stop_services.log
    Should Not Contain          ${output}	        failed
	
Checking if stopping services log contains warning
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/local_logs/autoft/auto_stop_services.log
    Should Not Contain          ${output}	        warn
	
Checking if stopping services log contains error
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/local_logs/autoft/auto_stop_services.log
    Should Not Contain          ${output}	        error
	
Checking if ENIQ services are started successfully
    [Tags]                      SB
    Set Client Configuration    timeout=180 seconds     prompt=#:
    ${output}=                  Execute Command         bash /eniq/admin/bin/manage_eniq_services.bsh -a start -s ALL -l /eniq/local_logs/autoft/auto_start_services.log -N
    Should Contain              ${output}	        ENIQ services started correctly
	
Checking if starting services log is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/local_logs/autoft/ | grep auto_start_services.log
    Should Contain              ${output}	        auto_start_services.log

Checking if starting services log contains failed
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/local_logs/autoft/auto_start_services.log
    Should Not Contain          ${output}	        failed
	
Checking if starting services log contains warning
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/local_logs/autoft/auto_start_services.log
    Should Not Contain          ${output}	        warn
	
Checking if starting services log contains error
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/local_logs/autoft/auto_start_services.log
    Should Not Contain          ${output}	        error


Checking value of SystemMaxUse in journald.conf
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /etc/systemd/journald.conf | grep SystemMaxUse | cut -f2 -d'=' | grep 8G
    Should Contain              ${output}	        8G
	
Checking if usage.log is created successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         ls -l /eniq/sentinel/log/ | grep usage.log
    Should Contain              ${output}	        usage.log
	
Checking if usage.log contains error
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/sentinel/log/usage.log | grep -i error
    Should Not Contain          ${output}	        error
	
Checking if usage.log contains warning
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/sentinel/log/usage.log | grep -i warn
    Should Not Contain          ${output}	        warning
	
Checking if usage.log contains failure
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/sentinel/log/usage.log | grep -i failed
    Should Not Contain          ${output}               failed
	
Checking if techpack log contains error
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${DATE}=                    Execute Command         date +%Y.%m.%d
    ${DATE1}=                   Execute Command         date --date='yesterday' +%Y.%m.%d
    ${file}=                    Run Keyword And Return Status       Execute Command         find /eniq/log/sw_log/tp_installer/*_tp_installer.log | egrep "${DATE}|${DATE1}"
    IF                          ${file} == True
        ${output}=                      Execute Command         cat /eniq/log/sw_log/tp_installer/${DATE}_*_tp_installer.log /eniq/log/sw_log/tp_installer/${DATE1}_*_tp_installer.log | grep -i error
        Should Not Contain              ${output}               ERROR
    ELSE
        Skip                            File not present for ${DATE} and ${DATE1}
    END
    #Set Client Configuration    timeout=25 seconds      prompt=#:
    #${output}=                  Execute Command         cat /eniq/log/sw_log/tp_installer/*_tp_installer.log | grep -i error
    #Should Not Contain          ${output}	        error
	
Checking if techpack log contains warning
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         cat /eniq/log/sw_log/tp_installer/*_tp_installer.log | grep -i warning
    Should Not Contain          ${output}	        warning
	
Checking if techpack log contains failure
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${DATE}=                    Execute Command         date +%Y.%m.%d
    ${DATE1}=                   Execute Command         date --date='yesterday' +%Y.%m.%d
    ${file}=                    Run Keyword And Return Status       Execute Command         find /eniq/log/sw_log/tp_installer/*_tp_installer.log | egrep "${DATE}|${DATE1}"
    IF                          ${file} == True
        ${output}=                      Execute Command         cat /eniq/log/sw_log/tp_installer/${DATE}_*_tp_installer.log /eniq/log/sw_log/tp_installer/${DATE1}_*_tp_installer.log | grep -i fail
        Should Not Contain              ${output}               failed
    ELSE
        Skip                            File not present for ${DATE} and ${DATE1}
    END

    #${output}=                  Execute Command         cat /eniq/log/sw_log/tp_installer/*_tp_installer.log | grep -i fail
    #Should Not Contain          ${output}	        failed
	
Checking if dwhdb is running fine
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/dwhdb status" | grep "dwhdb is running OK"
    Should Contain              ${output}	        dwhdb is running OK
	
Checking if services on eniq-dwhdb are stopped successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/dwhdb stop"
    Should Contain              ${output}	        Service stopping eniq-dwhdb
	
Checking if services on eniq-dwhdb are not running
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/dwhdb status" | grep "dwhdb is not running"
    Should Contain              ${output}	        dwhdb is not running
	
Checking if services on eniq-dwhdb are started successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/dwhdb start"
    Should Contain              ${output}               Service enabling eniq-dwhdb
	
Checking if services on eniq-dwhdb are running
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/dwhdb status" | grep "dwhdb is running OK"
    Should Contain              ${output}               dwhdb is running OK
	
Checking if repdb is running fine
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/repdb status" | grep "repdb is running OK"
    Should Contain              ${output}	        repdb is running OK
	
Checking if services on eniq-repdb are stopped successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/repdb stop"
    Should Contain              ${output}               Service stopping eniq-repdb

Checking if services on eniq-repdb are not running
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/repdb status" | grep "repdb is not running"
    Should Contain              ${output}               repdb is not running

Checking if services on eniq-repdb are started successfully
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/repdb start"
    Should Contain              ${output}	        Service enabling eniq-repdb

Checking if services on eniq-repdb are running 
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${output}=                  Execute Command         su - dcuser -c "/eniq/sw/bin/repdb status" | grep "repdb is running OK"
    Should Contain              ${output}	        repdb is running OK

Checking if there is only one default route
    [Tags]                      SB
    Set Client Configuration    timeout=25 seconds      prompt=#:
    ${ip_type}=                 Execute Command         cat /eniq/installation/config/ip_type
        IF                          $ip_type == "IPv6"
                ${output}=                  Execute Command         netstat -nr -6 | grep -w "UG" | head -1 | awk '{print $4}'
                Should Contain              ${output}               1
        ELSE
                ${output}=                  Execute Command         netstat -nr | grep -w "UG" | wc -l | grep 1
                Should Contain              ${output}               1
        END
