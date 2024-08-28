*** Variables ***

${IMAGE_DIR}     ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\sikuli-images
${IMAGE_DIR_NEW}     ${EXEC_DIR}\\Other\\sikuli-images
${scripts}        ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Scripts\\IronPythonScripts
${file_loc}       ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\Files
${dxp_file_loc}     ${EXEC_DIR}\\ENIQ_TC_Automation\\NetAn\\Other\\DXP_Files
${host}          localhost
${username}      Administrator
${password}      teamci@2017
${PORT}          2640

${puttyServer}      ieatrcxb3720.athtem.eei.ericsson.se
${puttyPort}        22
${puttyUserName}    root
${puttyPassword}    Eniq@1234

${PMDataKeywordFile}                PMDataWebUI.robot
${PMEXKeywordFile}                  PMExplorerWebUI.robot
${WCDMAKeywordFile}					WcdmaWebUI.robot
${EnergyReportKeywordsFile}         EnergyReportWebUI.robot
${LTEKPIDashboardKeywordsFile}      LTE_KPIDashboardWebUI.robot
${PMalarmingKeywordsFile}			PMAlarmWebUI.robot
${NRUplinkInterferenceKeywordsFile}    NRUplinkInterferenceWebUI.robot
${CMCCKeywordsFile}                 CMCCWebUI.robot
${Router6kFile}                     Router6kWebUI_Spotfire_12.robot
${UplinkInterferenceFile}           UplinkInterferenceWebUI.robot
${IMSCapacityKeywordsFile}          IMSCapacityWebUI.robot
${NRAppKeywords}					NRAppCoverageMapWebUI_Spotfire_14.robot


${workerAnalysis_1}=    spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Alarming/PM-Alarming/Analyses/WorkerAnalysis_1&waid=3AH914fNnUaTfpKlfYvdW-191037061e1aG9&wavid=0
${workerAnalysis_2A}=    spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Alarming/PM-Alarming/Analyses/WorkerAnalysis_2A&waid=MRS2oo4xzka3fY4SFyeiu-141209061edMr1&wavid=0
${workerAnalysis_2B}=    spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Alarming/PM-Alarming/Analyses/WorkerAnalysis_2B&waid=j5cRMQznvkKlGcF7-pilZ-191037061e4pgs&wavid=0
${workerAnalysis_3}=    spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Alarming/PM-Alarming/Analyses/WorkerAnalysis_3&waid=jMUyLM7BP0S7R3SDMiB6F-191037061e1aG9&wavid=0
	
${base_url}=       https://localhost/
${app_coverage_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/LTE/App-Coverage-Map/Ericsson-App-Coverage-Map/Analyses/App%20Coverage%20Map&waid=525ytmg_kU6Tra-m8daGP-150608061eYDmt&wavid=0
${pma_url}=      spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Alarming/PM-Alarming/Analyses/PM%20Alarming&waid=-xDvWY5lpk-gp30yipjqU-150608061ev1Ts&wavid=0
${enm_url}=      https://ieatenm5300-9.athtem.eei.ericsson.se/
${scheduling_and_routing}=       spotfire/#/schedulingRouting?tabId=overview
${ims_url}=      spotfire/wp/analysis?file=/Ericsson%20Library/IMS/IMS-Analysis/Ericsson-IMS-Capacity-Analysis/Analyses/Ericsson-IMS-Capacity-Analysis&waid=wvRsOLxisk6XmIoi8nn2F-181911061eT_3E&wavid=0
${rpo_wcdma_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/WCDMA/WCDMA%20Dashboard/Analyses/WCDMA%20Dashboard&waid=2YWaZOjFak2hyjQxrS6zc-021007061eCSSi&wavid=0
${rpo_lte_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/Radio-Common/RAN%20Performance%20Overview/Ericsson-RAN-Performance-Overview/Analyses/RAN%20Performance%20Overview%20-%20LTE&waid=OgcNxZURBkG6qk6faPTKs-031027061e3mHM&wavid=0
${energyreport_url}=         spotfire/wp/analysis?file=/Ericsson%20Library/Radio-Common/Energy-Report/Ericsson-Energy-Report/Analyses/Energy_Report&waid=YL3Mu8TX5kybJnuZXqvTz-140552061eKlKa&wavid=0
${app_coverage_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/LTE/App-Coverage-Map/Ericsson-App-Coverage-Map/Analyses/App%20Coverage%20Map&waid=krrItdfhgkWW-KhMIttEM-121229061eu1LU&wavid=0
${uplink_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/Radio-Common/RAN%20Uplink%20Interference/Ericsson-RAN-Uplink-Interference/Analyses/RAN_Uplink_Interference&waid=NbuAybjOi0K23gf77q5Fw-210855061ee3i5&wavid=0
${pmex_url}=       spotfire/wp/analysis?file=/Ericsson%20Library/General/PM%20Explorer/PM-Explorer/Analyses/PM%20Explorer&waid=Tza-om0C4Emhp9dxoJ0wu-091024061e335T&wavid=0
${volte_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/LTE/VoLTE/Ericsson-VoLTE-Report/Analyses/Volte_Guided_Analysis&waid=YEawD2FE6k2ctwsXXwI76-070619061eAb4y&wavid=0
${rno-mrr_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/GSM/GSM%20Optimization%20Reports/MRR/Analyses/MRR&waid=jWL8Eji7vEOyB6xgey0gL-070619061eAb4y&wavid=0
${nr-lte_timing_advance_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/NR%20and%20LTE/NR-and-LTE-Timing-Advance/Ericsson-NR-and-LTE-Timing-Advance-Analysis/Analysis/NR%20and%20LTE%20Timing%20Advance%20Analysis&waid=hxaZJuVwoke06Bqgg_FO3-080620061eP1Nv&wavid=0y
${nrNsa_url}=      spotfire/wp/analysis?file=/Ericsson%20Library/5g/NR%20NSA/Ericsson-NR-KPI-Dashboard/Analyses/NR%20NSA%20KPI%20Dashboard&waid=adrzqqwSUUyiT9N6ykRHh-180447061eIJoJ&wavid=0
${adminui}=    https://ieatrcxb3720.athtem.eei.ericsson.se:8443/adminui/servlet/LoaderStatusServlet
${vo_nr_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/VoNR/Voice%20over%20NR%20%28VoNR%29/Analysis/VoNR&waid=xYI7ar8pc0ikJspGNs8m3-0918335ab6RKHp&wavid=0
${nodes_and_services_url}=       spotfire/#/nodesServices?tabId=network&viewId=nodeManager&nodeId=9b1b1a0f-f855-4bfc-a248-b00c985b1fd4&serviceId=b4236e02-5258-494d-b805-49d82e0de69e
${nodes_and_services_url_s12}=           spotfire/ui/nodesServices/network/3aeec630-835c-4740-b24f-f2b633b9301f/10b0a95e-af47-4336-8400-39b7c3ade126
${ltekpi_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/LTE/LTE%20KPI%20Dashboard/Analysis/LTE%20KPI%20Dashboard&waid=Ii980YsXcE2csdLcQXYhH-140945061eahN4&wavid=0
${counter_mapping}=    spotfire/wp/analysis?file=&waid=s3mws0qGVE6wXJ4X8PFVB-250610061e0ud-&wavid=0
${clearcase}      https://clearcase-eniq.seli.wh.rnd.internal.ericsson.com/eniqdel
${cmcc_url}=      spotfire/wp/analysis?file=/Ericsson%20Library/General/CM%20Consistency%20Check/Analyses/CM%20Consistency%20Check&waid=7V_xc7lLPU61g7NFUW-za-191037061eCrtX&wavid=0
${nr_uplink_url}=    spotfire/wp/analysis?file=/Ericsson%20Library/5g/NR%20Uplink%20Interference/Analysis/NR%20Uplink%20Interference&waid=u5eqYOTyck6aELgF-9EWz-2216127ab5YhFe&wavid=0
${router6k_url} =    spotfire/wp/analysis?file=/Ericsson%20Library/Transport/Transport%20%28Router%206000%29%20Performance/Analysis/Transport%20%28Router%206000%29%20Performance

${Missing_Data_Message}=   No data to display. All data may have been filtered out or the data table is empty.
${nr_app_coverage_url}=    spotfire/wp/OpenAnalysis?file=5aaead63-14c0-4241-9d20-c3b8ae06694b
${4070_nr_app_coverage}=	 spotfire/wp/analysis?file=/Ericsson%20Library/5g/NR%20App%20Coverage/MSA/ieatrcxb4070/Analyses/NR%20App%20Coverage&waid=q6Elc-aTMEyIEEnSC3d1g-0411073f38BQSk&wavid=0