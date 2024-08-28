*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            BuiltIn
Resource           ../../../Resources/resource.txt

*** Variables ***
${len1}            ^(?=.*).{5,30}
${len2}            ^(?=.*).{9,30}
${dig}             [0-9]
${low}             [a-z]
${up}              [A-Z]
${dbua}            [ # % ~ _ + @ : ! * = } , { . / ]
${dbun}            [ ` $ ^ & ) ( - | \ ; " ' > < ? ]
${rdua}            [ # % ~ _ + @ : * = } , { . ]
${rdun}            [ ! / ' $ ^ & ) ( - | \ ; " ' > < ? ]
${dcua}            [ % ~ _ + : ! * = , . / ]
${dcun}            [ # @ } { ' $ ^ & ) ( - | \ ; " ' > < ?  ]
${spc}             ^\\S*$

*** Test Cases ***
DBA Password should be of length 5-30
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase 

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
	ELSE
	${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}	
	END
    
    Should Match Regexp         ${pwd}                        ${len1}
	
DBA Password should contain atleast one digit
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${dig}
	
DBA Password should contain atleast one lowercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END        

    Should Match Regexp         ${pwd}                        ${low}
	
DBA Password should contain atleast one uppercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
 
    Should Match Regexp         ${pwd}                        ${up}
	
DBA Password should contain atleast one special character from #%~_+@:!*=},{./
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
       
        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
 
    Should Match Regexp         ${pwd}                        ${dbua}
	
DBA Password should not contain characters which are not allowed
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
 
        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END 
    
    Should Not Match Regexp     ${pwd}                        ${dbun}
	
DBA Password should not contain any spaces
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DBAPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
 
        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END 
    
    Should Match Regexp         ${pwd}                        ${spc}

DC Password should be of length 5-30
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
    
    Should Match Regexp         ${pwd}                        ${len1}
	
DC Password should contain atleast one digit
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
 
    Should Match Regexp         ${pwd}                        ${dig}
	
DC Password should contain atleast one lowercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
    
    Should Match Regexp         ${pwd}                        ${low}
	
DC Password should contain atleast one uppercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
 
    Should Match Regexp         ${pwd}                        ${up}
	
DC Password should contain atleast one special character from #%~_+@:!*=},{./
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
 
        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
    
    Should Match Regexp         ${pwd}                        ${dbua}
	
DC Password should not contain characters which are not allowed
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Not Match Regexp     ${pwd}                        ${dbun}
	
DC Password should not contain any spaces
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END
    
    Should Match Regexp         ${pwd}                        ${spc}
	
DCBO Password should be of length 5-30
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${len1}
	
DCBO Password should contain atleast one digit
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${dig}
	
DCBO Password should contain atleast one lowercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
        
	IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d 
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${low}
	
DCBO Password should contain atleast one uppercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
       
        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${up}
	
DCBO Password should contain atleast one special character from #%~_+@:!*=},{./
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

        IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${dbua}
	
DCBO Password should not contain characters which are not allowed
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
        
	IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Not Match Regexp     ${pwd}                        ${dbun}
	
DCBO Password should not contain any spaces
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCBOPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase
        
	IF                      '${state}' == 'Y'
	${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${spc}
	
DCPUBLIC Password should be of length 5-30
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${len1}
	
DCPUBLIC Password should contain atleast one digit
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${dig}
	
DCPUBLIC Password should contain atleast one lowercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${low}
	
DCPUBLIC Password should contain atleast one uppercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${up}
	
DCPUBLIC Password should contain atleast one special character from #%~_+@:!*=},{./
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${dbua}
	
DCPUBLIC Password should not contain characters which are not allowed
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Not Match Regexp     ${pwd}                        ${dbun}
	
DCPUBLIC Password should not contain any spaces
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DCPUBLICPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${spc}
	
DWHREP Password should be of length 5-30
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${len1}
	
DWHREP Password should contain atleast one digit
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${dig}
	
DWHREP Password should contain atleast one lowercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${low}
	
DWHREP Password should contain atleast one uppercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${up}
	
DWHREP Password should contain atleast one special character from #%~_+@:*=},{.
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${rdua}
	
DWHREP Password should not contain characters which are not allowed
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Not Match Regexp     ${pwd}                        ${rdun}
	
DWHREP Password should not contain any spaces
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep DWHREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${spc}
	
ETLREP Password should be of length 5-30
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${len1}
	
ETLREP Password should contain atleast one digit
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${dig}
	
ETLREP Password should contain atleast one lowercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${low}
	
ETLREP Password should contain atleast one uppercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${up}
	
ETLREP Password should contain atleast one special character from #%~_+@:*=},{.
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${rdua}
	
ETLREP Password should not contain characters which are not allowed
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Not Match Regexp     ${pwd}                        ${rdun}
	
ETLREP Password should not contain any spaces
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword= | cut -f1 -d'=' --complement | head -1
    ${state}=                   Execute Command               cat /eniq/installation/config/niq.ini | grep ETLREPPassword_Encrypted= | cut -f1 -d'=' --complement | head -1
    ${strong_passphase}=        Execute Command               cat /eniq/sw/conf/strong_passphrase

	IF                      '${state}' == 'Y'
        ${pwd}                      Execute Command               echo '${value}' | openssl base64 -d
        ELSE
        ${pwd}=                     Execute Command               echo '${value}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${strong_passphase}
        END

    Should Match Regexp         ${pwd}                        ${spc}

DCUSER Password should be of length 9-30
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value1}=                  Execute Command               cat /eniq/sw/conf/dcuser_password_file
    ${value2}=                  Execute Command               cat /eniq/sw/conf/strong_passphrase
    ${pwd}=                     Execute Command               echo '${value1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value2}

    Should Match Regexp         ${pwd}                        ${len2}
	
DCUSER Password should contain atleast one digit
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value1}=                  Execute Command               cat /eniq/sw/conf/dcuser_password_file
    ${value2}=                  Execute Command               cat /eniq/sw/conf/strong_passphrase
    ${pwd}=                     Execute Command               echo '${value1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value2}
	
    Should Match Regexp         ${pwd}                        ${dig}
	
DCUSER Password should contain atleast one lowercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value1}=                  Execute Command               cat /eniq/sw/conf/dcuser_password_file
    ${value2}=                  Execute Command               cat /eniq/sw/conf/strong_passphrase
    ${pwd}=                     Execute Command               echo '${value1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value2}
	
    Should Match Regexp         ${pwd}                        ${low}
	
DCUSER Password should contain atleast one uppercase letter
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value1}=                  Execute Command               cat /eniq/sw/conf/dcuser_password_file
    ${value2}=                  Execute Command               cat /eniq/sw/conf/strong_passphrase
    ${pwd}=                     Execute Command               echo '${value1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value2}
	
    Should Match Regexp         ${pwd}                        ${up}
	
DCUSER Password should contain atleast one special character from %~_+:!*=,./
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value1}=                  Execute Command               cat /eniq/sw/conf/dcuser_password_file
    ${value2}=                  Execute Command               cat /eniq/sw/conf/strong_passphrase
    ${pwd}=                     Execute Command               echo '${value1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value2}
	
    Should Match Regexp         ${pwd}                        ${dcua}

DCUSER Password should not contain characters which are not allowed
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value1}=                  Execute Command               cat /eniq/sw/conf/dcuser_password_file
    ${value2}=                  Execute Command               cat /eniq/sw/conf/strong_passphrase
    ${pwd}=                     Execute Command               echo '${value1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value2}
	
    Should Not Match Regexp     ${pwd}                        ${dcun}

DCUSER Password should not contain any spaces
    [Tags]                      II
    Set Client Configuration    timeout=25 seconds            prompt=#:
    ${value1}=                  Execute Command               cat /eniq/sw/conf/dcuser_password_file
    ${value2}=                  Execute Command               cat /eniq/sw/conf/strong_passphrase
    ${pwd}=                     Execute Command               echo '${value1}' | openssl enc -aes-256-ctr -md sha512 -a -d -salt -pass pass:${value2}
	
    Should Match Regexp         ${pwd}                        ${spc}

