test_variable=''
preconfigured_mwshost = '10.45.196.7'
preconfigured_mwshostname = 'atrcxb2954'
preconfigured_mwsuser = 'root'
preconfigured_mwspwd = 'shroot12'
#'crypt:h0GTD5U+b6s5ICYPr+hdNr3snAhGZ/k4kju+CYtnVQkpyHW3wBJlBcrhrPr+FO3OI0hGyiqFUHU='

eniq_upg_host='10.45.199.33'
eniq_upg_hostname = '10.45.199.33'
eniq_upg_username = 'root'
eniq_upg_password = 'shroot12'

#mwshost = '10.45.198.174'
#mwshostname = 'ieatrcx4086.athtem.eei.ericsson.se'


mwshostname = '10.45.196.7'
mwshost = 'atrcxb2954'
mwsuser = 'root'
mwspwd = 'Infra#123'
mwsname = 'mwshost[:len(mwshost)-23]'

eniqhost = '10.45.197.183'
eniqhostname = 'ieatrcxb6081.athtem.eei.ericsson.se'
eniquser = 'root'
eniqpwd = 'Infra$123'
#'crypt:BRbOx0JPxdal9q5FNOmVvDgOA+nxXTTSRWIjORD+xCfuf0YPItm3qNxNgzhWgOYqm5TOWH1OsyI='

#media path on installed mws
mountpath = '/JUMP/INSTALL_PATCH_MEDIA/'
#'/JUMP/INSTALL_PATCH_MEDIA/5/RHEL'
patchver = 'RHEL7.9-3.0.13'

#chached media path on pre_configured mws
preconfigured_mws_cached_mountpath = '/JUMP/INSTALL_PATCH_MEDIA/5/'

domain_name = 'athtem.eei.ericsson.se'

rhel_version_installed_mws = '7.9'
rhel_version_installed_eniq = '7.9'
patch_version_installed_mws = '3.0.11'
patch_version_installed_eniq = '3.0.13'

om_media_version = '22.4.4'
om_release = om_media_version.replace('.','_')[:len(om_media_version)-2]
#services to be checked for active and enabled status

named = 'named'
nfs = 'nfs'
autofs = 'autofs'
multiuser = 'multi-user.target'
tftp = 'tftp'
xinetd = 'xinetd'

#Vlan Id's
#Update the vlan_id's for the servers configured as part of mws_II.
#Leave the vlan_id as empty if not updated

storage_vlan = 'eno1'
backup_vlan = ''
management_vlan = ''

#Path to latest package version cached on preconfigured mws server

cached_path_to_ERICstroconfig = '/JUMP/OM_LINUX_MEDIA/OM_LINUX_022_4/22.4.4/om_linux/sanconfig/'
