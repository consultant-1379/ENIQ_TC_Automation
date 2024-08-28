*** Keywords ***
Connect to server
    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=10
    Login    ${user_for_vapp}    ${pass_for_vapp}

Connect to server as a dcuser
    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=10
    Login    ${user_for_vapp}    ${pass_for_vapp}    

Connect to physical server
    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=100s    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#:
    Login    ${user_for_vapp}    ${pass_for_vapp}

Open connection as root user
    Open Connection    ${host_123}      port=${port_for_vapp}    timeout=10
    Login    ${root_user}    ${root_pwd}

Connect to physical server as root user with prompt
    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=100s    prompt=REGEXP:${SERVER}\\[\\S+\\]\\s{\\w+}\\s#:
    Login    ${root_user}    ${root_pwd}

Connect to physical server as non-root user
    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=10
    Login    ${non_rootuser}    ${non_rootpass}

Connect to physical server as prilveleged-user
    Open Connection    ${host_123}    port=${port_for_vapp}    timeout=10
    Login    ${non_user}    ${non_pass}


Switching to root user
    Write    su - root
    ${output_2}=    Read    delay=2s
    Write    ${root_pwd}    
    ${output_1}=    Read    delay=2s