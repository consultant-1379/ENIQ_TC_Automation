#!/bin/bash

echo "Table Name:";
read input


echo "Table Name: '$input'"
arr=(${input//":"/ })

INSTALLER_DIR=/eniq/sw/installer
CONF_DIR=/eniq/sw/conf
LOG_DIR=/eniq/log/sw_log
VECTOR_FLAG_DIR=/eniq/sw/conf/vectorflags
LS=/usr/bin/ls
RM=/usr/bin/rm
ECHO=/usr/bin/echo
CP=/usr/bin/cp
EGREP=/usr/bin/egrep
SED=/usr/bin/sed
TR=/usr/bin/tr
TEE=/usr/bin/tee
DATE=/usr/bin/date

. ${CONF_DIR}/niq.rc

_dir_=`/usr/bin/dirname $0`
SCRIPTHOME=`cd $_dir_ 2>/dev/null && pwd || echo $_dir_`

if [ -s $SCRIPTHOME/../../admin/lib/common_functions.lib ]; then
    . $SCRIPTHOME/../../admin/lib/common_functions.lib
else
	$ECHO "Could not find $SCRIPTHOME/../../admin/lib/common_functions.lib"
	exit 63
fi

########################################################################
# Function: remove_connection_string
# Removes/Deletes connection string once the script terminates
#
# Arguments: None
#
# Return Values: None
remove_connection_string()
{
if [ -f $connection_string_dc ]; then
  $RM -f $connection_string_dc
  if [ $? != 0 ]; then
    $ECHO "Unable to delete $connection_string_dc"
  fi
fi

if [ -f $connection_string_dwhrep ]; then
  $RM -f $connection_string_dwhrep
  if [ $? != 0 ]; then
    $ECHO "Unable to delete $connection_string_dwhrep"
  fi
fi

if [ -f $connection_string_dcpublic ]; then
  $RM -f $connection_string_dcpublic
  if [ $? != 0 ]; then
    $ECHO "Unable to delete $connection_string_dcpublic"
  fi
fi

if [ -f $connection_string_dwhrep_local ]; then
  $RM -f $connection_string_dwhrep_local
  if [ $? != 0 ]; then
    $ECHO "Unable to delete $connection_string_dwhrep_local"
  fi
fi

if [ -f $connection_string_etlrep ]; then
  $RM -f $connection_string_etlrep
  if [ $? != 0 ]; then
    $ECHO "Unable to delete $connection_string_etlrep"
  fi
fi
}

trap remove_connection_string EXIT


DWHDBPASSWORD=`inigetpassword DWH -v DCPassword -f ${CONF_DIR}/niq.ini`
DCPUBLIC_PASSWORD=`inigetpassword DWH -v DCPUBLICPassword -f ${CONF_DIR}/niq.ini`
DWHDB_PORT=`inigetpassword DWH -v PortNumber -f ${CONF_DIR}/niq.ini`
DWH_SERVER_NAME=`inigetpassword DWH -v ServerName -f ${CONF_DIR}/niq.ini`
ETLREPUser=`inigetpassword REP -v ETLREPUsername -f ${CONF_DIR}/niq.ini`
ETLREPPASSWORD=`inigetpassword REP -v ETLREPPassword -f ${CONF_DIR}/niq.ini`
DWHREPUSER=`inigetpassword REP -v DWHREPUsername -f ${CONF_DIR}/niq.ini`
DWHREPPASSWORD=`inigetpassword REP -v DWHREPPassword -f ${CONF_DIR}/niq.ini`
REP_PORT=`inigetpassword REP -v PortNumber -f ${CONF_DIR}/niq.ini`
REP_SERVER_NAME=`inigetpassword REP -v ServerName -f ${CONF_DIR}/niq.ini`

connection_string_dc=/var/tmp/encrypt_$$.txt
connection_string_dwhrep=/var/tmp/encrypt2_$$.txt
connection_string_dcpublic=/var/tmp/encrypt3_$$.txt
connection_string_dwhrep_local=/var/tmp/encrypt4_$$.txt
connection_string_etlrep=/var/tmp/encrypt5_$$.txt
connection_string_decrypt_dc="-nogui -c \"eng=${DWH_SERVER_NAME};links=tcpip{host=${DWH_SERVER_NAME};port=${DWHDB_PORT}};uid=dc;pwd=${DWHDBPASSWORD}\" -onerror exit" 
connection_string_decrypt_dwhrep="-nogui -c \"eng=${REP_SERVER_NAME};links=tcpip{host=${REP_SERVER_NAME};port=${REP_PORT}};uid=$DWHREPUSER;pwd=$DWHREPPASSWORD\" -onerror exit"
connection_string_decrypt_dcpublic="-nogui -c \"eng=${DWH_SERVER_NAME};links=tcpip{host=${DWH_SERVER_NAME};port=${DWHDB_PORT}};uid=dcpublic;pwd=${DCPUBLIC_PASSWORD}\" -onerror exit"
connection_string_decrypt_dwhrep_local="-c \"uid=${DWHREPUSER};pwd=${DWHREPPASSWORD};eng=${REP_SERVER_NAME}\" -host localhost -port $REP_PORT -nogui -onerror exit" 
connection_string_decrypt_etlrep="-c \"uid=${ETLREPUser};pwd=${ETLREPPASSWORD};eng=${REP_SERVER_NAME}\" -host localhost -port $REP_PORT -nogui -onerror exit"
  get_encrypt_file "${connection_string_decrypt_dc}" "${connection_string_dc}"
  get_encrypt_file "${connection_string_decrypt_dwhrep}" "${connection_string_dwhrep}"
  get_encrypt_file "${connection_string_decrypt_dcpublic}" "${connection_string_dcpublic}"
  get_encrypt_file "${connection_string_decrypt_dwhrep_local}" "${connection_string_dwhrep_local}"
  get_encrypt_file "${connection_string_decrypt_etlrep}" "${connection_string_etlrep}"
. /eniq/sybase_iq/IQ-*/IQ-*.sh
 
sybase_env_variables_ec=$?
if [ $sybase_env_variables_ec -ne 0 ]; then
     $ECHO "Unable to find sybase env variables"
fi

DBISQL=$(which dbisql)


tablenames="$(${DBISQL} @${connection_string_dwhrep} "select distinct substr(substr(DATAFORMATID,charindex('))',DATAFORMATID)+3),1,charindex(':',substr(DATAFORMATID,charindex('))',DATAFORMATID)+3))-1) as TABLENAME from dataitem where  DATAFORMATID like '$input%';" | $EGREP -v '(----|TABLENAME|rows|Execution)' | $SED '/^\s*$/d')"
	
#$ECHO "$connection_strin_dwhrep[0]"
	
#$ECHO $tablenames
	
arr1=(${tablenames//" "/ })

mkdir OutputFiles
	 
for val in "${arr1[@]}";
	
do 
#command=$(${DBISQL} @${connection_string_dc} "select * from " | $EGREP -v '(----|TABLENAME|rows|Execution|tab)' | $SED '/^\s*$/d')


#echo "$command" > /eniq/home/dcuser/OutputFiles/temp.txt
#awk 'NR>1' /eniq/home/dcuser/OutputFiles/temp.txt > /eniq/home/dcuser/OutputFiles/$val.txt
$ECHO $val
done
command=$(${DBISQL} @${connection_string_dc} "select * from ${input}" | $EGREP -v '(----|TABLENAME|rows|Execution|tab)' | $SED '/^\s*$/d')


echo "$command" > /eniq/home/dcuser/OutputFiles/temp.txt
awk 'NR>1' /eniq/home/dcuser/OutputFiles/temp.txt > /eniq/home/dcuser/OutputFiles/${input}.txt