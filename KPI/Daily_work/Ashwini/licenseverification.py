import re


import os

def License_verification(file_one , file_two ):
    a=file_one.splitlines()
    for i,x in enumerate(a,1):

        if re.search(f'{file_two}:',x):
            print(f'License {file_two} is found on line \t{x}')
            break
    else:
        print(f'License {file_two} not found')
    
  
cc='''CXC4010584::Ericsson Network IQ PM Alarm Module::FAJ8010774
CXC4010585::Ericsson GSM BSS PM Tech Pack::FAJ8010774
CXC4010586::Ericsson WCDMA RAN PM Tech Pack::FAJ8010774
CXC4010587::Ericsson CS Core (AXE) PM Tech Pack::FAJ8010774
CXC4010588::Ericsson MGW PM Tech Pack::FAJ8010774
CXC4010589::Ericsson SGSN PM Tech Pack::FAJ8010774
CXC4010590::Ericsson GGSN PM Tech Pack::FAJ8010774
CXC4010591::Ericsson SASN PM Tech Pack::FAJ8010774
CXC4010593::Ericsson IMS IPworks PM Tech Pack::FAJ8010774
CXC4010595::Ericsson IS-SBG PM TP::FAJ8010774
CXC4010638::Ericsson SARA PM Tech Pack::FAJ8010774
CXC4010639::Ericsson GSM BSS EBS Tech Pack::FAJ8010774
CXC4010640::Ericsson SGSN EBS PM Tech Pack::FAJ8010774
CXC4010641::Ericsson WCDMA RAN EBS PM Tech Pack::FAJ8010774
CXC4010643::Ericsson MTAS PM TP::FAJ8010774
CXC4010644::Ericsson CUDB PM Tech Pack::FAJ8010774
CXC4010645::Ericsson SmartEdge PM Tech Pack::FAJ8010774
CXC4010673::Ericsson SAPC PM Tech Pack::FAJ8010774
CXC4010697::Ericsson ML-PPP PM Tech Pack::FAJ8010774
CXC4010698::Ericsson CPG PM Tech Pack::FAJ8010774
CXC4010726::Ericsson SNMP MIBII PM Tech Pack::FAJ8010774
CXC4010777::Ericsson LTE RAN PM Tech Pack::FAJ8010774
CXC4010797::Ericsson HSS PM Tech Pack::FAJ8010774
CXC4010886::Ericsson SIU PM Tech Pack::FAJ8010774
CXC4011086::Ericsson IS-MGW PM Tech Pack::FAJ8010774
CXC4011087::Ericsson IS-MGC PM Tech Pack::FAJ8010774
CXC4011138::Ericsson TSS-AXE PM Tech Pack::FAJ8010774
CXC4011139::Ericsson AXD-301 PM Tech Pack::FAJ8010774
CXC4011140::Ericsson IS-TGC PM Tech Pack::FAJ8010774
CXC4011269::Ericsson BULK CM Tech Pack::FAJ8010774
CXC4011416::Ericsson IPT-NMS Topology Tech Pack::FAJ8010774
CXC4011417::Ericsson IP & Transport Tech pack::FAJ8010774
CXC4011460::Ericsson CSCF PM Tech Pack::FAJ8010774
CXC4011462::Ericsson PGM PM Tech Pack::FAJ8010774
CXC4011464::Ericsson MRFC PM Tech Pack::FAJ8010774
CXC4011496::Ericsson IPPROBE PM Tech Pack::FAJ8010774
CXC4011500::Ericsson DSC PM Tech Pack::FAJ8010774
CXC4011645::Ericsson FFAX-LTE PM Tech Pack::FAJ8010775
CXC4011719::Ericsson BBSC PM TP::FAJ8010774
CXC4011720::Ericsson SDNC PM TP::FAJ8010774
CXC4011832::Ericsson WCG PM Tech Pack::FAJ8010774
CXC4012006::Ericsson UPG PM Tech Pack::FAJ8010774
CXC4012099::Ericsson FFAX-WCDMA PM Tech Pack::FAJ8010775
CXC4012115::Ericsson vEME PM Tech Pack::FAJ8010774
CXC4012128::Information Store::FAJ8010774
CXC4012194::Ericsson vPP PM Tech Pack::FAJ8010774
CXC4012288::Ericsson NR PM Tech Pack::FAJ8010774
CXC4012312::Ericsson BSP PM Tech Pack::FAJ8010774
CXC4012351::Ericsson vAFG PM Tech Pack::FAJ8010774
CXC4012391::Ericsson GSM Optimization TechPack::FAJ8010776
CXC4012400::Ericsson 5G Core CCDM PM TechPack::FAJ8010774
CXC4012401::Ericsson 5G Core CCES PM TechPack::FAJ8010774
CXC4012403::Ericsson 5G Core CCRC PM TechPack::FAJ8010774
CXC4012404::Ericsson 5G Core CCSM PM TechPack::FAJ8010774
CXC4012459::Ericsson PCC PM TechPack::FAJ8010774
CXC4012460::Ericsson SCEF PM TechPack::FAJ8010774
CXC4012398::Ericsson 5G Core SC PM TechPack::FAJ8010774
CXC4012499::Ericsson vNSDS PM TechPack::FAJ8010774
CXC4012399::Ericsson 5G Core PCG PM TechPack::FAJ8010774
CXC4012402::Ericsson 5G Core CCPC PM TechPack::FAJ8010774
CXC4012542::Ericsson 5G Core SMSF PM TechPack::FAJ8010774
CXC4012041::Ericsson VoWi-Fi Analysis::FAJ8010776
CXC4012574::Ericsson TCIM TechPack::FAJ8010774
CXC4010598::Ericsson BSS KPI Report::FAJ8010775
CXC4010599::Ericsson WCDMA RAN KPI Report::FAJ8010775
CXC4010600::Ericsson HSPA feature Report::FAJ8010775
CXC4010601::Ericsson MSC KPI Report::FAJ8010775
CXC4010602::Ericsson MGW KPI Report::FAJ8010775
CXC4010603::Ericsson SGSN KPI Report::FAJ8010775
CXC4010699::Ericsson Service Aware Report::FAJ8010775
CXC4010727::Ericsson UDC Basic Report Package::FAJ8010775
CXC4010781::Ericsson LTE RAN KPI Report::FAJ8010775
CXC4010852::Ericsson Channel Element Utilization Report::FAJ8010775
CXC4010854::Ericsson GGSN KPI Report::FAJ8010775
CXC4010932::Busy Hour Administration::FAJ8010774
CXC4011024::Ericsson CPG KPI Report::FAJ8010775
CXC4011032::Ericsson MME KPI Report::FAJ8010775
CXC4011015::Ericsson LTE TN Monitoring Report::FAJ8010775
CXC4011014::Ericsson MSS License Utilization Report::FAJ8010775
CXC4011270::Ericsson MSC Blade Reports Package for Load Statistics::FAJ8010775
CXC4011461::Ericsson CSCF PM KPI Report::FAJ8010775
CXC4011463::Ericsson PGM KPI Report::FAJ8010775
CXC4011465::Ericsson MRFC KPI Report::FAJ8010775
CXC4011473::Ericsson IMS IPworks KPI Report::FAJ8010775
CXC4011474::Ericsson IS-SBG KPI Report::FAJ8010775
CXC4011475::Ericsson MTAS KPI Report::FAJ8010775
CXC4011487::Ericsson HSS KPI Report::FAJ8010775
CXC4011501::Ericsson DSC KPI Report::FAJ8010775
CXC4011600::Ericsson IP RAN KPI Report::FAJ8010775
CXC4011645::Ericsson FFAX-LTE KPI Report::FAJ8010775
CXC4011142::Ericsson TSS-AXE KPI Report::FAJ8010775
CXC4011143::Ericsson AXD-301 KPI Report::FAJ8010775
CXC4011144::Ericsson IS-TGC KPI Report::FAJ8010775
CXC4011097::Ericsson IS-MGW KPI Report::FAJ8010775
CXC4011149::Ericsson IS-MGC KPI Report::FAJ8010775
CXC4011466::Ericsson IP & Transport Node KPI Report::FAJ8010775
CXC4011644::Ericsson IP & Transport service and Link level KPI report::FAJ8010775
CXC4011833::Ericsson WCG KPI Report::FAJ8010775
CXC4011497::Ericsson TWAMP Report::FAJ8010775
CXC4010602::Ericsson MRSv Report::FAJ8010775
CXC4012099::Ericsson FFAX-WCDMA KPI Report::FAJ8010775   
CXC4011474::Ericsson IS-SBGv KPI Report::FAJ8010775                 
CXC4012113::Ericsson EIR-FE KPI Report::FAJ8010775
CXC4012165::Ericsson vEME Overview Report::FAJ8010775
CXC4010727::Ericsson CUDB Report Package::FAJ8010775
'''
bb='CXC4010585'
# License_verification(cc,bb)