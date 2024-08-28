*** Settings ***
Suite Setup      Open Connection and SSH Login
Suite Teardown    Close All Connections

Resource           ../../Resources/cTAF_resource.resource

Library            OperatingSystem
Library            SSHLibrary  10 seconds
Library            String

*** Test Cases ***
Test ciphers parameter is configured properly or not in sshd_config file
    ${result}=       Execute Command   cat /etc/ssh/sshd_config | grep Cipher
    ${get_lines_cipher_sshd}=      Get Lines Matching Regexp    ${result}      Ciphers aes256-ctr,aes192-ctr,aes128-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
    Should Be Equal     ${get_lines_cipher_sshd}      Ciphers aes256-ctr,aes192-ctr,aes128-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com

Test ciphers parameter is configured properly or not in ssh_config file
    ${result}=       Execute Command   cat /etc/ssh/ssh_config | grep Cipher
    ${get_lines_cipher_ssh}=      Get Lines Matching Regexp    ${result}      Ciphers aes256-ctr,aes192-ctr,aes128-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
    Should Be Equal     ${get_lines_cipher_ssh}      Ciphers aes256-ctr,aes192-ctr,aes128-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
    
Test ciphers parameter is configured properly in SSH daemon
    ${result}=        Execute Command       sshd -T | grep ciphers
    ${get_lines_cipher}=        Get Lines Matching Regexp    ${result}      ciphers aes256-ctr,aes192-ctr,aes128-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com
    Should Be Equal     ${get_lines_cipher}    ciphers aes256-ctr,aes192-ctr,aes128-ctr,chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com   

Test MACS parameter is configured properly or not in sshd_config file
    ${result}=       Execute Command    cat /etc/ssh/sshd_config | grep MAC
    ${get_lines_mac_sshd}=      Get Lines Matching Regexp    ${result}      MACs hmac-sha2-512,hmac-sha2-256,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
    Should Be Equal     ${get_lines_mac_sshd}      MACs hmac-sha2-512,hmac-sha2-256,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com

Test MACS parameter is configured properly or not in ssh_config file
    ${result}=       Execute Command    cat /etc/ssh/sshd_config | grep MAC
    ${get_lines_mac_ssh}=      Get Lines Matching Regexp    ${result}      MACs hmac-sha2-512,hmac-sha2-256,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
    Should Be Equal     ${get_lines_mac_ssh}      MACs hmac-sha2-512,hmac-sha2-256,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
    
Test MACS parameter is configured properly in SSH daemon
    ${result}=        Execute Command       sshd -T | grep macs
    ${get_lines_macs}=        Get Lines Matching Regexp    ${result}      macs hmac-sha2-512,hmac-sha2-256,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
    Should Be Equal     ${get_lines_macs}       macs hmac-sha2-512,hmac-sha2-256,hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com
