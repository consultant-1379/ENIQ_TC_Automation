import opensession_runcommand
import sys
sys.path.append('../Resources/Variables')
import Variables
    
def compare_kernel_versions(mwshost,mwsuser,mwspwd,hostname,username,password):
    #open connection to mws server
    check_kernel_package = "ls " + Variables.preconfigured_mws_cached_mountpath + "RHEL/RHEL" + Variables.rhel_version_installed_eniq + "-" + Variables.patch_version_installed_eniq + "/packages/|grep -E kernel-[0-9]+"
    package_kernel = opensession_runcommand.connect_to_terminal_runcommand(host=mwshost,username=mwsuser,password=mwspwd,command=check_kernel_package)
    #open connection to eniq server
    eniqkernelversion = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=username,password=password,command="uname -r")
    #compare kernel
    if eniqkernelversion in package_kernel:
        return("True")
    else:
        return("False")
