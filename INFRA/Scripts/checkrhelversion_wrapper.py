import opensession_runcommand

    

def compare_kernel_versions(mwshost,mwsuser,mwspwd,eniqhost,eniquser,eniqpwd):
    #open connection to mws server
    packagelist = opensession_runcommand.connect_to_terminal_runcommand(host=mwshost,username=mwsuser,password=mwspwd,command="cd /JUMP/INSTALL_PATCH_MEDIA/5/RHEL/RHEL7.9-3.0.13/packages/; ls -l|grep kernel").split("\n")
    package_kernel = packagelist[1].split()[8][7:34]
    #open connection to eniq server
    eniqkernelversion = opensession_runcommand.connect_to_terminal_runcommand(host=eniqhost,username=eniquser,password=eniqpwd,command="uname -r")

    #compare kernel
    if package_kernel==eniqkernelversion:
        return("True")
    else:
        return("False")
