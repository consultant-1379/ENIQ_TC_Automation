import opensession_runcommand
def compare_kernel_versions(mwshost,mwsuser,mwspwd):
    #open connection to mws server
    packagelist = opensession_runcommand.connect_to_terminal_runcommand(host=mwshost,username=mwsuser,password=mwspwd,command="cd /JUMP/INSTALL_PATCH_MEDIA/5/RHEL/RHEL7.9-3.0.13/packages/; ls -l|grep kernel").split("\n")
    package_kernel = packagelist[1].split()[8][7:34]
     #open connection to eniq server
    kernelversion = opensession_runcommand.connect_to_terminal_runcommand(host=mwshost,username=mwsuser,password=mwspwd,command="uname -r")


    #compare kernel
    if package_kernel==kernelversion:
        return("True")
    else:
        return("False")
