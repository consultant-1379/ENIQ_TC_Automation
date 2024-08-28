#!/bin/bash

echo "TP Name:";
read input


echo "TP Name: '$input'"
arr=(${input//":"/ })
arr2=(${arr[0]//"_"/ })

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

if [ ${arr2} == "DC" -a ${arr2[2]} != "LLE" -a ${arr2[2]} != "IPRAN" -a ${arr2[2]} != "WLE"  -a ${arr2[2]} != "FFAXW" -a ${arr2[2]} != "FFAX" ]
then
tablenames="$(${DBISQL} @${connection_string_dwhrep} "select distinct dataformatid as TABLENAME from dataitem where dataformatid like '$input%';" | $EGREP -v '(----|TABLENAME|rows|Execution|Note: Some of the data values have been truncated for display purposes.)' | $SED '/^\s*$/d')"
else
tablenames="$(${DBISQL} @${connection_string_dwhrep} "select distinct substr(ReferenceColumn.TYPEID,charindex('))',ReferenceColumn.TYPEID)+3) as TABLENAME from referencecolumn where  typeid like '$input%';" | $EGREP -v '(----|TABLENAME|rows|Execution)' | $SED '/^\s*$/d')"
fi

	
#$ECHO "$connection_strin_dwhrep[0]"
	
#$ECHO $tablenames
	
arr1=(${tablenames//" "/ })

mkdir OutputFiles
	 
for val in "${arr1[@]}";
	
do 
#echo ${arr2[2]}
if [ ${arr2} == "DC" -a ${arr2[2]} != "LLE" -a ${arr2[2]} != "IPRAN" -a ${arr2[2]} != "WLE"  -a ${arr2[2]} != "FFAXW" -a ${arr2[2]} != "FFAX" ]
then

arr3=(${val//":"/ })
command=$(${DBISQL} @${connection_string_dc} "select * from ${arr3[2]}_raw" | $EGREP -v '(----|TABLENAME|rows|Execution)')
echo "$command" > /eniq/home/dcuser/OutputFiles/temp.txt
sed '1d' /eniq/home/dcuser/OutputFiles/temp.txt > /eniq/home/dcuser/OutputFiles/${arr3[2]}.txt
echo ${arr3[2]}

else
command=$(${DBISQL} @${connection_string_dc} "select * from ${val}" | $EGREP -v '(----|TABLENAME|rows|Execution)')
echo "$command" > /eniq/home/dcuser/OutputFiles/temp.txt
sed '1d' /eniq/home/dcuser/OutputFiles/temp.txt > /eniq/home/dcuser/OutputFiles/$val.txt
echo $val

fi

#echo "$command"

#awk 'NR>1' /eniq/home/dcuser/${arr[0]}_OutputFiles/temp.txt > /eniq/home/dcuser/${arr[0]}_OutputFiles/$val.txt

done
rm -rf /eniq/home/dcuser/OutputFiles/temp.txt