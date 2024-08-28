import opensession_runcommand
import os
import paramiko
def check_emc_package_exist(hostname,user,pwd):
	emcpackage =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls /boot/ -A |egrep -iv 'efi|grub2|lost*|initramfs-0-rescue|vmlinuz-0-*' ")
	p=[]
	emcpackage = emcpackage.split()
	emcpackage1 =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="rpm -qa kernel")
	emcpackage1 = emcpackage1.split()
	for i in range (len(emcpackage1)):
		package = emcpackage1[i].split('kernel')
		p.append(package[1])
	count=0
	for i in range (len(emcpackage)):
		for k in range (len(p)):
			if p[k] in emcpackage[i]:
				count = count+1
				continue
	if count==len(emcpackage):
		return("True")
	else:
		return("False")
