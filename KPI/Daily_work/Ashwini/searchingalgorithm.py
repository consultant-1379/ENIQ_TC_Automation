


L = ["CXC4010584::Ericsson Network IQ PM Alarm Module::FAJ8010774\n", 
"CXC4010585::Ericsson GSM BSS PM Tech Pack::FAJ8010774\n", 
"CXC4010586::Ericsson WCDMA RAN PM Tech Pack::FAJ8010774\n",
"CXC4010587::Ericsson CS Core (AXE) PM Tech Pack::FAJ8010774\n",
"CXC4010588::Ericsson MGW PM Tech Pack::FAJ8010774\n",
"CXC4010589::Ericsson SGSN PM Tech Pack::FAJ8010774\n",
"CXC4010590::Ericsson GGSN PM Tech Pack::FAJ8010774\n",
"CXC4010591::Ericsson SASN PM Tech Pack::FAJ8010774\n",
"CXC4010593::Ericsson IMS IPworks PM Tech Pack::FAJ8010774\n",
"CXC4010595::Ericsson IS-SBG PM TP::FAJ8010774\n",
"CXC4010638::Ericsson SARA PM Tech Pack::FAJ8010774\n",
"CXC4010639::Ericsson GSM BSS EBS Tech Pack::FAJ8010774\n",
"CXC4010640::Ericsson SGSN EBS PM Tech Pack::FAJ8010774\n",
"CXC4010641::Ericsson WCDMA RAN EBS PM Tech Pack::FAJ8010774\n",
"CXC4010643::Ericsson MTAS PM TP::FAJ8010774\n",
"CXC4010644::Ericsson CUDB PM Tech Pack::FAJ8010774\n",
"CXC4010645::Ericsson SmartEdge PM Tech Pack::FAJ8010774\n",
"CXC4010673::Ericsson SAPC PM Tech Pack::FAJ8010774\n",
"CXC4010697::Ericsson ML-PPP PM Tech Pack::FAJ8010774\n",
"CXC4010698::Ericsson CPG PM Tech Pack::FAJ8010774\n",]
"CXC4010726::Ericsson SNMP MIBII PM Tech Pack::FAJ8010774\n",
"CXC4010777::Ericsson LTE RAN PM Tech Pack::FAJ8010774\n",
"CXC4010797::Ericsson HSS PM Tech Pack::FAJ8010774\n",
"CXC4010886::Ericsson SIU PM Tech Pack::FAJ8010774\n",
"CXC4011086::Ericsson IS-MGW PM Tech Pack::FAJ8010774\n",
"CXC4011087::Ericsson IS-MGC PM Tech Pack::FAJ8010774\n",
"CXC4011138::Ericsson TSS-AXE PM Tech Pack::FAJ8010774\n",
"CXC4011139::Ericsson AXD-301 PM Tech Pack::FAJ8010774\n",
"CXC4011140::Ericsson IS-TGC PM Tech Pack::FAJ8010774\n",
"CXC4011269::Ericsson BULK CM Tech Pack::FAJ8010774\n",
"CXC4011416::Ericsson IPT-NMS Topology Tech Pack::FAJ8010774\n",
"CXC4011417::Ericsson IP & Transport Tech pack::FAJ8010774\n",
"CXC4011460::Ericsson CSCF PM Tech Pack::FAJ8010774\n",
"CXC4011462::Ericsson PGM PM Tech Pack::FAJ8010774\n",
"CXC4011464::Ericsson MRFC PM Tech Pack::FAJ8010774\n",
"CXC4011496::Ericsson IPPROBE PM Tech Pack::FAJ8010774\n",
CXC4011500::Ericsson DSC PM Tech Pack::FAJ8010774
CXC4011645::Ericsson FFAX-LTE PM Tech Pack::FAJ8010775
CXC4011719::Ericsson BBSC PM TP::FAJ8010774
CXC4011720::Ericsson SDNC PM TP::FAJ8010774\n"






file1 = open('myfile.txt', 'w')
file1.writelines(L)
file1.close()
# Using readlines()
file1 = open('myfile.txt', 'r')
Lines = file1.readlines()
  
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    print("Line{}: {}".format(count, line.strip()))

