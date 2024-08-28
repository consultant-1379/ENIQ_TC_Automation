#*************************************************************************
#	Ericsson Radio Systems AB                                     SCRIPT
#*************************************************************************
#
#  	(c) Ericsson Radio Systems AB 2020 - All rights reserved.
#  	The copyright to the computer program(s) herein is the property
#	of Ericsson Radio Systems AB, Sweden. The programs may be used
#	and/or copied only with the written permission from Ericsson Radio
#	Systems AB or in accordance with the terms and conditions stipulated
#	in the agreement/contract under which the program(s) have been
#	supplied.
#
#***************************************************************************************************
#	Name    : 	ebid_master_script.ps1
#	Date    : 	05/03/2021
#	Revision: 	A.1
#	Purpose : 	This powershell file is used to perform the Activities involved with BI upgrade automatically taking the inputs from ebid_user_inputs.ini
#	          	configuration file.  	
#
#	Usage   : 	ebid_master_script.ps1
#
#**************************************************************************************************************************************************************

# *************************************************************************************************************************************************************
#	All functions used in the script are defined here 
# *************************************************************************************************************************************************************

# ------------------------------------------------------------------------
#  Function to print date and time in the log file
# ------------------------------------------------------------------------

Function PrintDateTime()
{    
    "----------------------------------------------- " >>$global:LogFile 
     Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$global:LogFile
    "----------------------------------------------- " >>$global:LogFile      
}
<#
# ------------------------------------------------------------------------
#  Function to print date and time in Summary log file
# ------------------------------------------------------------------------

Function PrintDateTimeSummary()
{    
    "----------------------------------------------- " >>$global:SummaryLogFile 
     Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$global:SummaryLogFile
    "----------------------------------------------- " >>$global:SummaryLogFile      
}

#------------------------------------------------------------------------
# Function to check given input values .ini file is present or not
#------------------------------------------------------------------------

Function NullCheck($arg1, $arg2)
{
    if($arg1 -eq "")
    {
        "value of $arg2 could not be fetched" >>$AppLog
        return $false
    }
    else
    {
        "value of $arg2 is fetched" >>$AppLog
		return $true
    }
}
#>

# **************************************************************************************
#	Check if the user is Administrator.
# **************************************************************************************

function check_If_Admin 
{
	#Checking if Administrator
	
	PrintDateTime
	"`nChecking if Administrator" >>$global:LogFile
	try
	{
		$user = [Security.Principal.WindowsIdentity]::GetCurrent();
		$CheckUser  = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
		if($CheckUser)
		{
			check_If_NonAdmin
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Please log in as Administrator to proceed with BI Upgrade. `n" -ForegroundColor Red
			write-host "`n$time : [ERROR] All non-administrator users should log off from the server. `n" -ForegroundColor Red
			write-host "`n$time : FAILURE!!" -ForegroundColor Red
			EXIT (1)
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in check_If_Admin function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}
<#
# **************************************************************************************
#	Check if there are any Non Administrator users Logged in 
# **************************************************************************************

function check_If_NonAdmin
{
	PrintDateTime
	"`nChecking for other users" >>$global:LogFile
	try
	{
		$users = QUERY USER
		if($users.Length -gt 2)
		{
			"Non Administrator Users is/are logged in ">> $global:LogFile
			for ($i=1, $i -lt $users.Length, $i++)
			{
				$user = $users[$i].trim() -split ' {2,}'			
				if($user[0] -NotLike '*Administrator' )
				{
					handle_NonAdmin_Users -user $user[0], -session_Id $user[2]
				}
				else
				{
					return
				}
			}		
		}
		else
		{
			return
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in check_If_NonAdmin function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# **************************************************************************************
#	LOGOFF Non Administrator user
# **************************************************************************************

function handle_NonAdmin_Users ($user, $session_Id) 
{
	PrintDateTime
	"`nHandling Non Administrator users" >>$global:LogFile
	try
	{
		"Asking User $user to log off ">> $global:LogFile
		$answer = read-host -Prompt "`nAll non-administrator users need to logoff before taking backup.Do you want to logoff $user? (Y/N)" 
		if ($answer -eq "Y")
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : Logging off " $user -ForegroundColor Green
			LOGOFF $session_Id
		}
		elseif ($answer -eq "N")
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] All non-administrator users need to logoff to proceed" -ForegroundColor Red
			write-host("`n")
			write-host "`n$time : FAILURE!!" -ForegroundColor Red
			EXIT (1)
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Invalid Input. `n" -ForegroundColor Red
			handle_NonAdmin_Users -user $user,  -session_Id $session_Id
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in handle_NonAdmin_Users function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}
#>
# ------------------------------------------------------------------------
#  Function to identify the Deployment Type (BI Server or BI client)
# ------------------------------------------------------------------------

Function CheckIfBIInstalled()
{
	PrintDateTime
	"If the script is executed for upgrading the client software in a server where BIS and Client both components are installed. `nUpgrade will be performed only for Server Software component. " >>$global:LogFile																																																			 
	"Refer EBID, Installation and Upgrade Instructions document to perform Client software upgrade manually. " >>$global:LogFile																														 
	"`nChecking if BI is installed" >>$global:LogFile
	try
	{
        if(Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager")
        {   
			if(Test-Path ((Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir).InstallDir))
			{
				$global:BiInstallDir = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir).InstallDir
				$global:BiInstallDirLetter = $global:BiInstallDir.split("\")
				$global:BiInstallDirLetter = $BiInstallDirLetter[0] 
				$global:CCMDirectory = $global:BiInstallDir+"\SAP BusinessObjects Enterprise XI 4.0\win64_x64\ccm.exe"
				$global:BiServerFound = $True            
				$global:ServerFound = $True
                $global:Upgrade = $True
				"`nBI Server Software is Installed" >>$global:LogFile
			}
			else
			{
				"`nUnable to find BI Server Installed path" >>$global:LogFile
			} 
        }		
        elseif(Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora")
        {
            
			if(Test-Path (Get-ItemProperty -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora" -Name path).path)
			{
				$global:BiInstallDir = (Get-ItemProperty -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora" -Name path).path
				$global:BiInstallDirLetter = $global:BiInstallDir.split("\")
				$global:BiInstallDirLetter = $BiInstallDirLetter[0] 
				$global:BiClientFound = $True                     
				$global:ServerFound = $True
                $global:Upgrade = $True
				"`nBI Client Tools is Installed" >>$global:LogFile				
			}   
			else
			{
				"`nUnable to find BI Client Installed path" >>$global:LogFile
			}            
        }  
		else
        {
			"`nBI Server/Client Tools is not Installed" >>$global:LogFile
            if(Test-Path -Path "HKLM:\SOFTWARE\Citrix\Citrix Virtual Desktop Agent")
            {
                if(Test-path -Path (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Citrix\Citrix Virtual Desktop Agent' -Name InstallDir).InstallDir)
                {
                    $global:InstallClient = $true
                    $global:ServerFound = $True
                    "`nVDA components are installed in the server">>$global:LogFile
                    "`nInitiating Client initial installation" >>$global:LogFile
            	}
            }
            else
            {
                foreach($line in Get-Content $global:MasterScriptConfigFile)
                {
                    If($line -match "bi_install_client")
                    {
                        $LineSplit = "$line".split("=",2)
	                	$global:ClientStatus = $LineSplit[1].Trim() 
                        if(($global:ClientStatus -eq "No") -or ($global:ClientStatus -eq "N"))
                        {
                            $global:InstallServer = $true
                            "`nbi_install_client status is set to No" >>$global:LogFile
                            "`nInitiating Server initial installation" >>$global:LogFile
                        }
                        else
                        {
                            $global:InstallClient = $true
                            "`nbi_install_client status is set to Yes" >>$global:LogFile
                            "`nInitiating Client initial installation" >>$global:LogFile
                        }
                        $global:ServerFound = $True
                    }
                }
            }
		}  
		If($global:ServerFound -ne $True)
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] BI Server/Client Tools is not Installed." -ForegroundColor Red
			Exit
		}
		else
		{
			"`nFound the Server type proceeding to next stage.." >>$global:LogFile
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckIfBIInstalled function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to check the BI version
# ------------------------------------------------------------------------

Function CheckBIVersion ()
{
	PrintDateTime
	"`nChecking the BI version" >>$global:LogFile
	try
	{
		if([bool](Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-Object {$_.DisplayName -Match $global:BIVersionName}))
		{
			"`nServer already has BI Version: $global:BIVersionName " >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : $global:BIVersionName is already installed.`n" -ForegroundColor Green
			Exit
		}
		else
		{
			"`nServer doesnt have BI Version: $global:BIVersionName Proceeding further" >>$global:LogFile
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckBIVersion function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}
<#
# -----------------------------------------------------------------------------------
#  Function to Get User Input for Client
# -----------------------------------------------------------------------------------

Function GetBISFQDN()
{
	PrintDateTime
	"`nTaking User Input for BIS FQDN" >>$global:LogFile
	try
	{
		foreach($line in Get-Content $global:MasterScriptConfigFile ) 
		{        
			if($line -match "bis_fqdn =")
			{            
				$LineSplit = "$line".split("=",2)
				$global:bis_fqdn = $LineSplit[1].Trim()
				$HasValue = NullCheck $global:bis_fqdn "BIS FQDN"
				If($HasValue -eq $False)
				{
					"Config file is not updated" >>$global:LogFile
					$global:BISFQDN = Read-Host "`nEnter BIS FQDN"
					[System.Net.Dns]::GetHostByName("$bis_name") >> $global:LogFile 2>&1
					If ( $? -eq "True" )
					{	
						"IP is pingable hence updating Config file" >>$global:LogFile
						UpdateMasterIniClient
					}	
					Else 
					{			
						$time = get-date -Format "yyyy MM dd HH:mm:ss"
						write-host "`n$time : [ERROR] Failed to resolve IP address for '$global:BISFQDN'. Please update the $global:MasterScriptConfigFile file manually." -ForegroundColor Red
						EXIT
					}
				}
				Else
				{
					"Config file is already updated" >>$global:LogFile
				}
			}
			else
			{
				"no match" >>$global:LogFile
			}
		}			
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in GetBISFQDN function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : `n[ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
	
}

# -----------------------------------------------------------------------------------
#  Function to Get BIS IP 
# -----------------------------------------------------------------------------------

Function GetBISIPAddress()
{
	PrintDateTime
	"`nUser Input for BIS IP" >> $global:LogFile 
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : Verifying if user input for BIS IP is required." -ForegroundColor Green
        if($global:Upgrade -eq $true)
        {
		    VerifyIfSIABoundToIP
        }
		if($global:IsBISIPRequired -ne "No")
		{
			foreach($line in Get-Content $global:MasterScriptConfigFile ) 
			{        
				if($line -match "bis_ip =")
				{ 
					"`nMatch for Bis_ip" >>$global:LogFile				
					$LineSplit = "$line".split("=",2)
					$global:ServerIPInput = $LineSplit[1].Trim()
					$HasValue = NullCheck $global:ServerIPInput "BIS IP"
					If($HasValue -eq $False)
					{
						$time = get-date -Format "yyyy MM dd HH:mm:ss"
						write-host "`n$time : SIA is not bound to Primary IP." -ForegroundColor Green
						$global:ServerIP = (Get-NetIPAddress).IPAddress
						$CountAttempt = 0
						$TempChecks = 0    
						while($TempChecks -ne 1)
						{
							if($CountAttempt -eq 3)
							{
								"`nExiting out, as user hasn't provided a valid input after 3 attempts." >>  $global:LogFile
								$time = get-date -Format "yyyy MM dd HH:mm:ss"
								write-host "`n$time : [ERROR] User failed to enter valid input.`n" -ForegroundColor Red
								EXIT(1)
							}
							$global:ServerIPInput = Read-Host "`nEnter Primary IP of BIS"
							$global:ServerIPInput = $global:ServerIPInput.Trim()
							
							if($global:ServerIP -contains $global:ServerIPInput)
							{
								"`nThe IP Address entered is BIS IP Address.`n" >> $global:LogFile 
								$TempChecks = 1		
							}
							else
							{
								$time = get-date -Format "yyyy MM dd HH:mm:ss"
								write-host "`n$time : [ERROR] The IP entered is incorrect." -ForegroundColor Red
								"`nThe IP entered is incorrect.`n" >> $log
								$CountAttempt = $CountAttempt + 1
							}
						}
					}
					else
					{
						"bis_ip is already updated in $global:MasterScriptConfigFile" >>$global:LogFile
                        write-host "`n$time : BIS IP is already updated in $global:MasterScriptConfigFile." -ForegroundColor Green
					}
				}
				else
				{
					"`nNo match for Bis_ip" >>$global:LogFile
				}
			}
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : SIA is already bound to Primary IP. Hence skipping user input for BIS IP." -ForegroundColor Green
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in GetBISIPAddress function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to Check if SIA is bound to IP
# -----------------------------------------------------------------------------------

Function VerifyIfSIABoundToIP()
{
	PrintDateTime
	"`nVerifying if SIA is Bound to IP.." >> $global:LogFile
	try
	{
		"Verifying if SIA is Bound to IP.." >> $global:LogFile
		if(test-path $global:BiInstallDir"\tomcat\webapps\AdminTools\FetchIPBoundToSIA.jsp") 
		{ 
			Remove-Item -Path $global:BiInstallDir"\tomcat\webapps\AdminTools\FetchIPBoundToSIA.jsp" -Force -recurse 
		}
		$max_error_count=1	
        
		Copy-Item "C:\ebid\install_config\FetchIPBoundToSIA.jsp" -Destination $global:BiInstallDir"\tomcat\webapps\AdminTools\" -Force
        
		if ($? -eq "True") 
		{
			$bytes_bis_password = [System.Text.Encoding]::UTF8.GetBytes($global:CmsPassword)
			$encoded_bis_password =[Convert]::ToBase64String($bytes_bis_password)
			$output = cscript C:\ebid\install_config\wget_custom.js http://$env:computername`:8080/AdminTools/FetchIPBoundToSIA.jsp?bo_password=$encoded_bis_password`&logtimestamp=$time_stamp			
			$FetchIPLog = "C:\ebid\install_config\log\FetchIPBoundToSIA_log-$time_stamp.log"
			if(test-path $FetchIPLog)
			{
				$executionLogs = Get-Content $FetchIPLog
				if($executionLogs -like "*FetchIPBoundToSIA - Successful*")
				{
					foreach($line in Get-Content $FetchIPLog) 
					{        
						if($line -match "PrimaryIP:")
						{            
							$LineSplit = "$line".split(":",2)
							$global:ServerIPInput = $LineSplit[1].Trim()
							$HasValue = NullCheck $global:ServerIPInput "BIS Primary IP"
							If($HasValue -eq $False)
							{
								$global:IsBISIPRequired = "Yes"
								"BIS Primary IP is not available" >>$global:LogFile
							}
							else
							{
								"BIS Primary IP is available and Validating" >>$global:LogFile
								$global:ServerIP = (Get-NetIPAddress).IPAddress
								if($global:ServerIP -contains $global:ServerIPInput)
								{
									$global:IsBISIPRequired = "No"
									"BIS Primary IP is Validated" >>$global:LogFile
                                    Set-ItemProperty $global:MasterScriptConfigFile -name IsReadOnly -value $false
		                            (Get-Content $global:MasterScriptConfigFile) -replace '^bis_ip =.+$', "bis_ip = $global:ServerIPInput" | Set-Content $global:MasterScriptConfigFile
								}
								else
								{
									$global:IsBISIPRequired = "Yes"
									"BIS Primary IP Validation Failed. Hence asking for User Input" >>$global:LogFile
								}
							}
						}
					}	
				}
				else
				{
					"Unable to find the status. Hence asking for User Input.." >> $global:LogFile
					$global:IsBISIPRequired  = "Yes"
				}
			} 
			else
			{
				"Unable to find logs. Hence asking for User Input.." >> $global:LogFile
				$global:IsBISIPRequired  = "Yes"
			}
		}
		else 
		{
			"Can't copy FetchIPBoundToSIA.jsp file " >> $global:LogFile	
			$global:IsBISIPRequired  = "Yes"
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in VerifyIfSIABoundToIP function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}


# -----------------------------------------------------------------------------------
#  Function to Get ENIQ IP 
# -----------------------------------------------------------------------------------

# Function GetENIQIPAddress()
{
	PrintDateTime
	"User Input for Eniq IP" >>  $global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : Verifying if user input for ENIQ IP is required." -ForegroundColor Green
		$status = Get-WmiObject -Class Win32_Service -Filter "Name='NfsService'"
		if(!$status)
		{
			foreach($line in Get-Content $global:MasterScriptConfigFile ) 
			{        
				if($line -match "eniq_server_ip =")
				{ 
					"`nMatch for eniq_server_ip" >>$global:LogFile				
					$LineSplit = "$line".split("=",2)
					$global:EniqServerIP = $LineSplit[1].Trim()
					$HasValue = NullCheck $global:EniqServerIP "ENIQ Server IP"
					If($HasValue -eq $False)
					{
						$time = get-date -Format "yyyy MM dd HH:mm:ss"
						write-host "`n$time : BI Logs for DDC is not enabled." -ForegroundColor Green
						$TempEniqChecks = 0    
						$CountAttempt = 0
						while($TempEniqChecks -ne 1)
						{
							if ($CountAttempt -eq 3)
							{
								"`nExiting out, as user hasn't provided a valid input after 3 attempts." >>  $global:LogFile
								$time = get-date -Format "yyyy MM dd HH:mm:ss"
								write-host "`n$time : [ERROR] User failed to enter valid input for ENIQ IP.`n" -ForegroundColor Red
								EXIT
							}
							$global:EniqServerIP = Read-Host "`nEnter ENIQ server IP"
							$validity = ( "$global:EniqServerIP" -Match "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" )
							$DotCount = ( "$global:EniqServerIP".ToCharArray() | Where-Object {$_ -eq '.'} | Measure-Object).Count
							If (($validity -ne "True") -and ($DotCount -ne 3))
							{
								$time = get-date -Format "yyyy MM dd HH:mm:ss"
								write-host "`n$time : [ERROR] Please enter a valid IP address." -ForegroundColor Red
								$CountAttempt= $CountAttempt + 1
								
							} 
							Else 
							{
								ping $global:EniqServerIP | Out-Null
								$TempEniqChecks=1
								If ($? -ne "True") 
								{
									"Warning! Could not ping the server $global:EniqServerIP" >> $global:LogFile
									$time = get-date -Format "yyyy MM dd HH:mm:ss"
									write-host "`n$time : Warning!! Could not ping the server $global:EniqServerIP!" -ForegroundColor Red
								}
							}
						}
						$time = get-date -Format "yyyy MM dd HH:mm:ss"
						write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
					}
					else
					{
						"eniq_server_ip is already updated in $global:MasterScriptConfigFile" >>$global:LogFile
						write-host "`n$time : ENIQ IP is already updated in $global:MasterScriptConfigFile" -ForegroundColor Green
						write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
					}
				}
				else
				{
					"`nNo match for eniq_server_ip" >>$global:LogFile
				}
			}
		}
		else
		{
			"nfs share is already configured so skipping user input for Eniq Server IP." >> $global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : BI Logs for DDC is already enabled. Hence skipping user input for ENIQ IP" -ForegroundColor Green
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in GetENIQIPAddress function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to UpdateMaster Ini File
# -----------------------------------------------------------------------------------

Function UpdateMasterIni()
{
	try
	{
		Set-ItemProperty $global:MasterScriptConfigFile -name IsReadOnly -value $false
		(Get-Content $global:MasterScriptConfigFile) -replace '^eniq_server_ip =.+$', "eniq_server_ip = $global:EniqServerIP" | Set-Content $global:MasterScriptConfigFile
		(Get-Content $global:MasterScriptConfigFile) -replace '^bis_ip =.+$', "bis_ip = $global:ServerIPInput" | Set-Content $global:MasterScriptConfigFile
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in GetENIQIPAddress function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to UpdateMaster Ini File for Client
# -----------------------------------------------------------------------------------

Function UpdateMasterIniClient()
{
	try
	{
		Set-ItemProperty $global:MasterScriptConfigFile -name IsReadOnly -value $false
		(Get-Content $global:MasterScriptConfigFile) -replace '^eniq_server_ip =.+$', "eniq_server_ip = $global:EniqServerIP" | Set-Content $global:MasterScriptConfigFile																																							
		(Get-Content $global:MasterScriptConfigFile) -replace '^bis_fqdn =.+$', "bis_fqdn = $global:BISFQDN" | Set-Content $global:MasterScriptConfigFile
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in UpdateMasterIniClient function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to UpdateMaster Ini File with Eniq server IP for Standalone server
# -----------------------------------------------------------------------------------

Function UpdateMasterIniClientStandalone()
{
	try
	{
		Set-ItemProperty $global:MasterScriptConfigFile -name IsReadOnly -value $false
		(Get-Content $global:MasterScriptConfigFile) -replace '^eniq_server_ip =.+$', "eniq_server_ip = $global:EniqServerIP" | Set-Content $global:MasterScriptConfigFile																																							
		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in UpdateMasterIniClientStandalone function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to check if instllation configurations files are present
# -----------------------------------------------------------------------------------

Function CheckingConfigFile()
{ 
	PrintDateTime
	"Determining install ini file path"  >>$global:LogFile
	try
	{		
		$global:InstallConfigFile42Sp6 = "C:\ebid\install\ebid_bi42_sp6_p4_server.ini"
		$global:InstallConfigFile42Sp7 = "C:\ebid\install\ebid_bi42_sp7_p5_server.ini"        
		$global:InstallConfigFile42Sp8 = "C:\ebid\install\ebid_bi42_sp8_server.ini"
		$global:InstallConfigFile42Sp8P7 = "C:\ebid\install\ebid_bi42_sp8_p7_server.ini"
		$global:InstallConfigFile42Sp9P3 = "C:\ebid\install\ebid_bi42_sp9_p3_server.ini"
		$global:InstallConfigFile43Sp1P9 = "C:\ebid\install\ebid_bi43_sp1_p9_server.ini"
		$global:InstallConfigFile43Sp2 = "C:\ebid\install\ebid_bi43_sp2_server.ini"
		$global:InstallConfigFile43Sp2P4 = "C:\ebid\install\ebid_bi43_sp2_p4_server.ini"
		$global:InstallConfigFile43Sp3 = "C:\ebid\install\ebid_bi43_sp3_server.ini"	
	
		if(Test-Path $InstallConfigFile43Sp3)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp3
		}
		elseif(Test-Path $InstallConfigFile43Sp2P4)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp2P4
		}
		elseif(Test-Path $InstallConfigFile43Sp2)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp2
		}
		elseif(Test-Path $InstallConfigFile43Sp1P9)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp1P9
		}															  
		elseif(Test-Path $InstallConfigFile42Sp9P3)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp9P3
		}
		elseif(Test-Path $InstallConfigFile42Sp8P7)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp8P7
		}
		elseif(Test-Path $InstallConfigFile42Sp8)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp8
		}
		elseif(Test-Path $InstallConfigFile42Sp7)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp7
		}
		elseif(Test-Path $InstallConfigFile42Sp6)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp6
		}	
		else
		{
			"The installation configuration file is missing from C:\ebid\install\ directory." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] The installation configuration file is missing from C:\ebid\install\ directory." -ForegroundColor Red
			EXIT
		}		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckingConfigFile function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to decrypting the  if instllation configurations files are present
# -----------------------------------------------------------------------------------

Function DecryptingConfigFile()
{
	PrintDateTime
	"Checking if install ini is decrypted and proceeding accordingly.."  >>$global:LogFile
	try
	{		
		$keyFile = "C:\ebid\install\key.txt"
		$InstallUnencrypted = $False
		foreach($line in Get-Content $global:InstallConfigFile) 
		{
			If($line -match "cmspassword=")
			{
				"Install File is not encrypted(C:\ebid\install)." >>$global:LogFile
				$global:InstallFile = $global:InstallConfigFile
				$InstallUnencrypted = $True
			}
		}
		if($InstallUnencrypted -eq $False)
		{
			if(Test-Path $keyFile)
			{
				"Decrypting input file"  >>$global:LogFile
				powershell -command ". C:\ebid\install_config\ebid_encryption_decryption.ps1; DecryptEBIDFile -path $global:InstallConfigFile -output 'C:\ebid\ebid_automation\tmp.txt' -type 'postinstall' ;"
				$global:InstallFile="C:\ebid\ebid_automation\tmp.txt"
			}
			else
			{
				"Key file not present in C:\ebid\install folder so exiting the script."  >>$global:LogFile
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] Key file not present in C:\ebid\install folder." -ForegroundColor Red
				Exit
			} 
		}
		ReadingInputs
		return
	}
	Catch
	{
		$_ >>$global:LogFile
		"`nException in DecryptingConfigFile function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to Fetch CMS password from ini file
# -----------------------------------------------------------------------------------

Function ReadingInputs()
{
    PrintDateTime 
	"Reading inputs"  >>$global:LogFile	
	try
	{		
		foreach($line in Get-Content $global:InstallFile) 
		{        
			if($line -match "cmspassword=")
			{            
				$LineSplit = "$line".split("=",2)
				$global:CmsPassword = $LineSplit[1].Trim()
				$HasValue = NullCheck $global:CmsPassword "Cms Password"
				If($HasValue -eq $False)
				{
					"cmspassword is not available" >>$global:LogFile
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : [ERROR] cmspassword is not updated in configuration file in C:\ebid\install\" -ForegroundColor Red
					Exit
				}
				else
				{
					"cmspassword is available" >>$global:LogFile
				}
			}
		}		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in ReadingInputs function." >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}  
}

# ------------------------------------------------------------------------
#  Function to Validate CMS passwords
# ------------------------------------------------------------------------

Function ValidateCMSPwd()
{
	PrintDateTime
	"`nValidating CMS Password:" >>$global:LogFile
	try
	{
		$service_name="BOEXI40SIA$env:computername"
		$service_status=(Get-Service -Name $service_name).status
		$display_name=(Get-Service -Name $service_name).DisplayName
		"$display_name is $service_status" >> $global:LogFile
		If ($service_status -ne "Running") 
		{
			write-host "`n$time : [ERROR] $display_name is not running. Please start the service manually and execute the script again." -ForegroundColor Red
			EXIT
		}
		$obj = &"$global:CCMDirectory"  -display -username Administrator -password $global:CmsPassword	
		$obj >>$global:LogFile		
		if($obj -like "*Unable*" ) 
		{
			"CMS password is not valid">>$global:LogFile			
		}
		else
		{
			"user input for CMS password is valid">>$global:LogFile
			$global:ValidPassword = $true
		}
		if($global:ValidPassword -eq $true)
		{
			"`nCMS password is validated. proceeding to next stage.." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : CMS password Validation : Successful. Proceeding to next stage.." -ForegroundColor Green
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] CMS password Validation : Failed." -ForegroundColor Red
			$bi_adm_password_encrypted = Read-Host "`nEnter BI Administrator Password" -AsSecureString
			$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($bi_adm_password_encrypted)            
			$new_password_cms = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
			if(($new_password_cms.length -eq 0 ))  
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] Password can not be empty. Execute the script again." -ForegroundColor Red
				"CMS password can not be empty. Execute the script again." >> $global:LogFile
				EXIT
			}
			$obj = &"$global:CCMDirectory"  -display -username Administrator -password $new_password_cms	
			$obj >>$global:LogFile		
			if($obj -like "*Unable*" ) 
			{
				"CMS password is not valid">>$global:LogFile
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] CMS password Validation : Failed." -ForegroundColor Red
				EXIT
			}
			else
			{
				$global:CmsPassword=$new_password_cms
				powershell -command ". C:\ebid\install_config\ebid_encryption_decryption.ps1; DecryptEBIDFile -path $global:InstallConfigFile -output 'C:\ebid\install\tmp.ini' -type 'postinstall' ;"
				$content = Get-content 'C:\ebid\install\tmp.ini'
				if (($content -match '.*cmspassword=.*')) 
				{
					$bi_adm_password = ($content -match '.*cmspassword=.*').subString(12)
				} 
				ForEach ($line in (Get-Content 'C:\ebid\install\tmp.ini' -Raw )) 
				{
					$line -replace "cmspassword=$bi_adm_password","cmspassword=$new_password_cms" | Out-File 'C:\ebid\install\tmp.ini' 
				}
				"Updated the new passowrd in the tmp file." >> $global:LogFile
				del  $global:InstallConfigFile
				"Deleted the current install ini file." >> $global:LogFile
				Rename-Item -Path 'C:\ebid\install\tmp.ini' -NewName $global:InstallConfigFile
				"Renamed the temporary ini with new name $install_config_file ." >> $global:LogFile
				del 'C:\ebid\install\key.txt'
				"Deleted the existing key and encrypting the new  $global:InstallConfigFile ." >> $global:LogFile
				if (!(Test-Path 'C:\ebid\install\key.txt')) 
				{ 
					powershell -command ". C:\ebid\install_config\ebid_encryption_decryption.ps1; EncryptEBIDFile -filepath $global:InstallConfigFile -type 'postinstall' ;"
					"Encrypted the new install ini successfully." >> $global:LogFile
				} 
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : CMS password Validation : Successful. Proceeding to next stage.." -ForegroundColor Green
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
				
			}
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in ValidateCMSPwd function." >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to verify if all the required media's are available
# ------------------------------------------------------------------------

Function VerifyMediasAvailability()
{
	PrintDateTime
	"`nChecking if all the required medias are available" >>$global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : Media Availability Check : In Progress." -ForegroundColor Green		
		if(Test-Path -Path $global:MediaPath)
		{ 
			if(Test-Path $global:EBIDMedia)
			{
				$global:AllMediasAvailable =  $global:AllMediasAvailable +1
				"`n$global:EBIDMedia media is available" >>$global:LogFile
			}
			else
			{
				"`n$global:EBIDMedia media is not available" >>$global:LogFile
			}
			if(Test-Path $global:SAPIQNWClientMedia)
			{
				$global:AllMediasAvailable =  $global:AllMediasAvailable +1
				"`n$global:SAPIQNWClientMedia media is available" >>$global:LogFile
			}
			else
			{
				"`n$global:SAPIQNWClientMedia media is not available" >>$global:LogFile
			}
			if(($global:BiServerFound -eq $true) -OR ($global:InstallServer -eq $true))
			{
                if(Test-Path $global:ServerMedia)
                {
				    $global:AllMediasAvailable =  $global:AllMediasAvailable +1
				    "`n$global:ServerMedia media is available" >>$global:LogFile
                }
                else
                {
                    "`n$global:ServerMedia media is not available" >>$global:LogFile
                }
			}
			elseif(($global:BiClientFound -eq $true) -OR ($global:InstallClient -eq $true))
			{
                if(Test-Path $global:ClientMedia)
                {
				    $global:AllMediasAvailable =  $global:AllMediasAvailable +1
				    "`n$global:ClientMedia media is available" >>$global:LogFile
                }
                else
                {
                    "`n$global:ClientMedia media is not available" >>$global:LogFile
                }
			}	
			else
			{
				if($global:BiServerFound -eq $true)
				{
					"`n$global:ServerMedia media is not available" >>$global:LogFile
				}
				else
				{
					"`n$global:ClientMedia media is not available" >>$global:LogFile
				}
			}
			if(Test-Path $global:WindowsMedia)
			{
				$global:AllMediasAvailable =  $global:AllMediasAvailable +1
				"`n$global:WindowsMedia media is available" >>$global:LogFile			
			}
			else
			{
				"`n$global:WindowsMedia media is not available" >>$global:LogFile
			}
		}
		else
		{
			"`n			not found" >>$global:LogFile
		}
		if($global:AllMediasAvailable -ne 4)
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Media Availability Check : Failed. Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}
		else
		{
			"`nAll the required medias are available proceeding to next stage" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : Media Availability Check : Successful. Proceeding to next stage.." -ForegroundColor Green	
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green			
		}
	}
	catch 
	{
		$_ >>$global:LogFile
		"`nException in VerifyMediasAvailability function." >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}

}


# -----------------------------------------------------------------------------------
#  Function to Pause Schedule
# -----------------------------------------------------------------------------------

Function PauseResumeSchedules()
{
	PrintDateTime
	"`n$global:ScheduleAction Schedules.." >> $global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : $global:ScheduleAction Schedules : In Progress." -ForegroundColor Green
		if(test-path $global:BiInstallDir"\tomcat\webapps\AdminTools\PauseResumeSchedules.jsp") 
		{ 
			Remove-Item -Path $global:BiInstallDir"\tomcat\webapps\AdminTools\PauseResumeSchedules.jsp" -Force -recurse 
		}
		$max_error_count=1	
		Copy-Item "C:\ebid\ebid_automation\PauseResumeSchedules.jsp" -Destination $global:BiInstallDir"\tomcat\webapps\AdminTools\" -Force
		if ($? -eq "True") 
		{
			$bytes_bis_password = [System.Text.Encoding]::UTF8.GetBytes($global:CmsPassword)
			$encoded_bis_password =[Convert]::ToBase64String($bytes_bis_password)
			$output = cscript C:\ebid\install_config\wget_custom.js http://$env:computername`:8080/AdminTools/PauseResumeSchedules.jsp?bo_password=$encoded_bis_password`&logtimestamp=$time_stamp`&Action=$global:ScheduleAction			
			$FetchScheduleLog = "C:\ebid\ebid_automation\log\PauseResumeSchedules_log-$time_stamp.log"
			if(test-path $FetchScheduleLog)
			{
				$executionLogs = Get-Content $FetchScheduleLog
				if($executionLogs -like "*PauseResumeSchedules - Successful*")
				{
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					"$global:ScheduleAction Schedules : Successful." >> $global:LogFile
					write-host "`n$time : $global:ScheduleAction Schedules : Successful. Proceeding to next stage.." -ForegroundColor Green
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : ***********************************************************************************" -ForegroundColor Green					
				}
				elseif($executionLogs -like "*PauseResumeSchedules - NoActionRequired*")
				{
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					"No Schedules in $global:ScheduleAction.." >> $global:LogFile
					write-host "`n$time : $global:ScheduleAction Schedules : Successful(No Schedules). Proceeding to next stage.." -ForegroundColor Green
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : ***********************************************************************************" -ForegroundColor Green					
				}
				else
				{
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : Unable to $global:ScheduleAction Schedules. Please do it manually" -ForegroundColor Red
					Exit
				}
			} 
			else
			{
				"Unable to find logs.." >> $global:LogFile
				if($global:ScheduleAction -eq "Pause")
				{
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : Unable to $global:ScheduleAction Schedules. Please do it manually" -ForegroundColor Red
					Exit
				}
				else
				{
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					"`n*********************************************************************************************************" >>$global:SummaryLogFile
					"`n$time : Unable to $global:ScheduleAction Schedules. Please do it manually. "  >>$global:SummaryLogFile
					"`n*********************************************************************************************************" >>$global:SummaryLogFile
				}
			}
		}
		else 
		{
			if($global:ScheduleAction -eq "Pause")
			{
				"Can't copy PauseResumeSchedules.jsp file " >> $global:LogFile	
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : Unable to $global:ScheduleAction Schedules. Please do it manually" -ForegroundColor Red
				Exit
			}
			else
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				"Can't copy PauseResumeSchedules.jsp file " >> $global:LogFile
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
				"`n$time : Unable to $global:ScheduleAction Schedules. Please do it manually. "  >>$global:SummaryLogFile
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
			}
			
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in PauseResumeSchedules function" >>$global:LogFile
		if($global:ScheduleAction -eq "Pause")
		{
			
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Unable to $global:ScheduleAction Schedules. Please do it manually. "  >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
		}
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Check and take BI content Backup if needed
# ------------------------------------------------------------------------

Function BIContentBackup()
{
	PrintDateTime
	"`n Take BI Content if required" >>$global:LogFile
	try
	{	
		 if(Test-Path -Path "HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion\Config")
		 {
			"`n Veritos NetBackup Client is already installed, so skipping BI Content Backup. Proceeding to next stage.." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			PauseResumeSchedules
		 }
		 else
		 {
			"`n Veritos NetBackup Client is not installed on the server, so taking BI content Backup" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			# Check if Script is executed as Administrator
			check_If_Admin
			PauseResumeSchedules
			DisableTasksInTaskScheduler
			CopylatestBackupScript
			#unmount Server Media
			UNMountMedia($global:ServerMedia)
			
			#unmount Client Media
			UNMountMedia($global:ClientMedia)
			
			#unmount EBID Automation Media
			UNMountMedia($global:EBIDMedia)
			
			#unmount Windows Media
			UNMountMedia($global:WindowsMedia)
			
			#unmount SAP IQ Client Media
			UNMountMedia($global:SAPIQNWClientMedia)
			CallBackupScript
			EnableTasksInTaskScheduler
		 }
	}
	catch 
	{
		$_ >>$global:LogFile
		"`nException in BIContentBackup function." >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}

}

# -----------------------------------------------------------------------------------
#  Function to Copy Latest Install Config Files
# -----------------------------------------------------------------------------------

Function CopylatestBackupScript()
{
	PrintDateTime
	try
	{
		$destination_Directory = "C:\ebid"
		$global:EBIDMediaDrive = MountMedia($global:EBIDMedia)
		$file_To_Be_Copied = ($global:EBIDMediaDrive + $global:BackupPath)
		copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
		if (test-path -Path ($destination_Directory+"\"+$global:BackupPath))
		{
			"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		}
		else
		{
			"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopylatestBackupScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to Copy Latest Housekeeping Script
# -----------------------------------------------------------------------------------

Function CopylatestHousekeepingScript()
{
	PrintDateTime
	try
	{
		if(Test-path -Path "C:\ebid\housekeeping")
		{
			"Housekeeping folder already present and replacing the latest housekeeping script." >>$global:LogFile
			$destination_Directory = "C:\ebid\housekeeping"
			$global:EBIDMediaDrive = MountMedia($global:EBIDMedia)
			$file_To_Be_Copied = ($global:EBIDMediaDrive + $global:HousekeepingScript)
			Get-ChildItem -Path "C:\ebid\housekeeping\*" -Recurse -File | % { $_.IsReadOnly=$False }
			Copy-Item $file_To_Be_Copied -Destination $destination_Directory -Force
			if(test-path -Path "C:\ebid\housekeeping\ebid_housekeeping.ps1")
			{
				"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			}
			else
			{
				
				"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
				Exit
			}
		}
		else
		{
			 "Housekeeping is not configured in the server. Hence copying latest housekeeping script is skipped.." >> $global:LogFile
		}
		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopylatestHousekeepingScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}


# ------------------------------------------------------------------------
#  Function to Call backup Script 
# ------------------------------------------------------------------------

Function CallBackupScript()
{       
    PrintDateTime
	"`nCalling Script to execute Automated BI Content Backup. Check $global:BackupScriptLog for progress" >>$global:LogFile
	try
	{
		$Argument = "AutoBackup"
		$global:BackupStatus = Invoke-Expression "$global:BackupScript $Argument"
		if(($global:resultToMasterScript -eq "Successful") -and ($global:ServiceRestartMasterScript -ne "Failed"))
		{
			"`nExecution of Automated BI Content Backup is successful. Proceeding to next stage" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : BI Content Backup : Successful. Proceeding to next stage.." -ForegroundColor Green
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		}
		elseif($global:resultToMasterScript -ne "Successful")
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Executing $global:BackupScript Failed. Check $global:BackupScriptLog for more details" -ForegroundColor Red		
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : BI Content Backup : Failed." -ForegroundColor Red
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Red
			Exit	
		}
		elseif($global:ServiceRestartMasterScript -eq "Failed")
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Unable to start BI Platform services, Please start the services Manually" -ForegroundColor Red
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CallBackupScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Disable Task in TaskScheduler 
# ------------------------------------------------------------------------

Function DisableTasksInTaskScheduler()
{       
    PrintDateTime
	"`n Disabling the Tasks in Task Scheduler Before BI Content Backup " >>$global:LogFile
	try
	{
		Get-ScheduledTask -TaskPath "\" | Stop-ScheduledTask >>$global:LogFile
		Get-ScheduledTask  -taskPath "\" | Disable-ScheduledTask >>$global:LogFile
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in DisableTasksInTaskScheduler function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Enable Task in TaskScheduler 
# ------------------------------------------------------------------------

Function EnableTasksInTaskScheduler()
{       
    PrintDateTime
	"`n Enabling the Tasks in Task Scheduler Before BI Content Backup " >>$global:LogFile
	try
	{
		Get-ScheduledTask  -taskPath "\" | Enable-ScheduledTask >>$global:LogFile
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in EnableTasksInTaskScheduler function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Find the Health Status of the server
# ------------------------------------------------------------------------

Function CheckHealthStatus()
{
	PrintDateTime
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : Server Health Check : In Progress." -ForegroundColor Green
		if($global:BiServerFound -eq $true)
		{			
			"`nChecking the Health Status of BI server" >>$global:LogFile
			CheckBIServerStatusNow
		} 
		elseif($global:BiClientFound -eq $true)
		{
			"`nChecking the Disk space of BI Client server" >>$global:LogFile
			CheckDiskSpace
			if($global:DiskSpaceStatus -ne $True)
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] InSufficient Space for Upgrade. Cleanup Drive space and try again." -ForegroundColor Red
				EXIT
			}
		}
        else
        {
            "`n Checking number of drives and diskspace required for Initial install" >>$global:LogFile
            CheckDiskSpaceForII
        }
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckHealthStatus function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Check Number of Drives and DriveSpace
# ------------------------------------------------------------------------
function CheckDiskSpaceForII()
{
	if($global:InstallServer -eq $true)
	{
		$disk = Get-WmiObject -Class Win32_logicaldisk -Filter "Drivetype=3"
		if($disk.Length -eq 2)
		{
			"`nNumber of Drives available are 2" >>$global:LogFile
			for($i=0;$i -lt $disk.Length;$i++)
			{
				$Driver = $disk[$i].DeviceID 
				if($Driver -match "C")
				{
					"`nInitial installation will not be performed on $Driver drive, CHecking for next drive" >>$global:LogFile
				}
				else
				{                
					$TotalSpace = [math]::Round(($disk[$i].Size)/1gb,2)
					$FreeSpace = [math]::Round(($disk[$i].FreeSpace)/1gb,2)                
					if($FreeSpace -gt 39)
					{
						"`nInitial installation will be performed on $Driver drive" >>$global:LogFile
						"Available check passed" >>$global:LogFile
						$global:InstallDirectory = $Driver+"\Program Files (x86)\SAP BusinessObjects\"
						$global:InstallDirectory >>$global:LogFile
						write-host "`n$time : Server Health Check : Successful. proceeding to next stage.." -ForegroundColor Green
						write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
					}
					else
					{
						$time = get-date -Format "yyyy MM dd HH:mm:ss"    
						Write-Host "`n$time : $Driver drive does not have enough space to start initial installation." -ForegroundColor Red
						Write-Host "`n$time : $Driver drive Should have minimum 39GB to start initial installation." -ForegroundColor Red
						"`n$time : $Driver drive does not have enough space to start initial installation." >>$global:LogFile
						"`n$time : $Driver drive Should have minimum 39GB to start initial installation." >>$global:LogFile
						EXIT
					}
				}
			}
		}
		elseif($disk.Length -gt 2)
		{
			"`nNumber of Drives available are more than 2" >>$global:LogFile
			$EnteredDrive = Read-Host "`nEnter the drive letter where you want to install BI (for example, D or E or F)" 
			if([bool](($disk.DeviceID) -match $EnteredDrive) -and ($EnteredDrive -ne "C"))
			{
				for($i=0;$i -lt $disk.Length;$i++)
				{
				$Driver = $disk[$i].DeviceID             
				if($Driver -match $EnteredDrive)
				{
					$TotalSpace = [math]::Round(($disk[$i].Size)/1gb,2)
					$FreeSpace = [math]::Round(($disk[$i].FreeSpace)/1gb,2)                
					if($FreeSpace -gt 39)
					{
						"`nInitial installation will be performed on $Driver drive" >>$global:LogFile
						"`nAvailable check passed" >>$global:LogFile
						$global:InstallDirectory = $Driver+"\Program Files (x86)\SAP BusinessObjects\"
						$global:InstallDirectory >>$global:LogFile
						write-host "`n$time : Server Health Check : Successful. proceeding to next stage.." -ForegroundColor Green
						write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
					}
					else
					{
						$time = get-date -Format "yyyy MM dd HH:mm:ss"    
						Write-Host "`n$time : $Driver drive does not have enough space to start initial installation." -ForegroundColor Red
						Write-Host "`n$time : $Driver drive Should have minimum 39GB to start initial installation." -ForegroundColor Red
						"`n$time : $Driver drive does not have enough space to start initial installation." >>$global:LogFile
						"`n$time : $Driver drive Should have minimum 39GB to start initial installation." >>$global:LogFile
						EXIT
					}
				}               
				}  
			}
			else
			{
				Write-Host "`n $EnteredDrive drive is an invalid drive. Please enter valid drive. C Drive is not recommended for installing. Please use other drive for installation." -ForegroundColor Red
				EXIT
			}                        
		}
		else
		{
			"`nNumber of Drives available are less than 2" >>$global:LogFile
			if($global:InstallServer -eq $true)
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				Write-Host "`n$time :  It is recommended to have at least 2 drives to install BI" -ForegroundColor Red
				EXIT
			}        
		}
	}
	else
	{		
		$disk = Get-WmiObject -Class Win32_logicaldisk -Filter "DeviceID='C:'"
		$FreeSpace = [math]::Round(($disk.FreeSpace)/1gb,2)
		if($FreeSpace -gt 13)
        {
            "`nInitial installation will be performed on C: drive" >>$global:LogFile
            "Available check passed" >>$global:LogFile            
            write-host "`n$time : Server Health Check : Successful. proceeding to next stage.." -ForegroundColor Green
            write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
        }
        else
        {
            $time = get-date -Format "yyyy MM dd HH:mm:ss"    
            Write-Host "`n$time : C drive does not have enough space to start initial installation." -ForegroundColor Red
            Write-Host "`n$time : C drive Should have minimum 13GB to start initial installation." -ForegroundColor Red
            "`n$time : C drive does not have enough space to start initial installation." >>$global:LogFile
            "`n$time : C drive Should have minimum 13GB to start initial installation." >>$global:LogFile
            EXIT
        }
	}
}

# ------------------------------------------------------------------------
#  Function to Mount Server Media and copy install ini
# ------------------------------------------------------------------------
function CopyIIIni()
{
    try
	{			
        if($global:InstallServer -eq $true)
        {
            $Media = $global:ServerMedia
            $ServerMediaDrive = MountMedia $Media		 
		    "Media: $Media is mounted in $ServerMediaDrive" >>$global:LogFile
            $File = $ServerMediaDrive+"ebid_scripts\ebid_*_server.ini"
        }
        elseif($global:InstallClient -eq $true)
        {
            $Media = $global:ClientMedia 
            $ClientMediaDrive = MountMedia $Media		 
		    "Media: $Media is mounted in $ClientMediaDrive" >>$global:LogFile
            $File = $ClientMediaDrive+"ebid_scripts\ebid_*_client.ini"
        }        
        if(Test-Path -path "C:\ebid\install")
        {
            $global:NewInstallini = (Get-ChildItem C:\ebid\install -Filter *.ini -Recurse | % { $_.FullName })
            Set-ItemProperty $global:NewInstallini -name IsReadOnly -value $false
            Copy-Item $File -Destination "C:\ebid\install"
        }
        else
        {
            New-Item C:\ebid\install -ItemType Directory | Out-Null
            Start-Sleep  -seconds 5
            Copy-Item $File -Destination "C:\ebid\install"
        }		 
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in MountMedia function for $Media" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Mount EBID Media and Copy input validate folder
# ------------------------------------------------------------------------
function ValidateInput()
{
    $EBIDMediaDrive = MountMedia $global:EBIDMedia
    "Media: $global:EBIDMedia is mounted in $EBIDMediaDrive" >>$global:LogFile
    $InputValidateFolder = $EBIDMediaDrive+"ebid_input_validate"     
    $InputValidationStatus = $False   
    if(test-Path "C:\ebid\ebid_input_validate")
    {
        "Input validate script already present and replacing it" >>$global:LogFile
        Get-ChildItem -Path "C:\ebid\ebid_input_validate\*" -Recurse -File | % { $_.IsReadOnly=$False }
        Copy-Item $InputValidateFolder"\ebid_input_validate.ps1" -Destination "C:\ebid\ebid_input_validate" -Force
    }
    else
    {
        "Copying Inputvalidate script" >>$global:LogFile
        Copy-Item $InputValidateFolder -Destination "C:\ebid\" -Recurse -Force
    }                       
    $Argument = "cmspassword"
    $CmsReturnStatus = CallInputScript $Argument
    if($CmsReturnStatus)
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"   
        Write-Host "`n$time : Validating Cms Password  : Successful." -ForegroundColor Green         
    }           

    $Argument = "clusterkey"
    $ClusterReturnStatus = CallInputScript $Argument
    if($ClusterReturnStatus)
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"  
        Write-Host "`n$time : Validating clusterkey Password  : Successful." -ForegroundColor Green           
    }    
    
    $Argument = "lcmpassword"
    $LcmReturnStatus = CallInputScript $Argument
    if($LcmReturnStatus)
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"  
        Write-Host "`n$time : Validating lcm Password  : Successful." -ForegroundColor Green                             
    }               

    $Argument = "sqlpassword"
    $SqlReturnStatus = CallInputScript $Argument
    if($SqlReturnStatus)
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"  
        Write-Host "`n$time : Validating sqlanywhere Password  : Successful." -ForegroundColor Green          
    }  
        
    $Argument = "sianame"
    $SiaReturnStatus = CallInputScript $Argument
    if($SiaReturnStatus)
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"    
        Write-Host "`n$time : Validating sianame  : Successful" -ForegroundColor Green
    } 

    $global:ProducyKey = Read-Host "`nEnter Product Key"
}

# ------------------------------------------------------------------------
#  Function to read and validate input entered by user
# ------------------------------------------------------------------------
function CallInputScript($Argument)
{
    $ErrorCount = 0
    $Valiation = $false
    while(($ErrorCount -ne 5) -AND ($Validation -ne $true))
    {
        if($Argument -eq "cmspassword")
        {
            $userInput= read-host -Prompt "`nEnter CMS Password" -AsSecureString
            $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
            $Global:NewCMSPassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()            
            $time = get-date -Format "yyyy MM dd HH:mm:ss"    
            Write-Host "`n$time : Validating Cms Password  : In Progress." -ForegroundColor Green
        }
        elseif($Argument -eq "clusterkey")
        {
            $userInput= read-host -Prompt "`nEnter Cluster Key" -AsSecureString
            $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
            $Global:ClusterKey= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()           
            $time = get-date -Format "yyyy MM dd HH:mm:ss"    
            Write-Host "`n$time : Validating clusterkey Password  : In Progress." -ForegroundColor Green            
        }
        elseif($Argument -eq "lcmpassword")
        {
            $userInput= read-host -Prompt "`nEnter LCM Password" -AsSecureString
            $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
            $Global:LCMPassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()            
            $time = get-date -Format "yyyy MM dd HH:mm:ss"    
            Write-Host "`n$time : Validating lcm Password  : In Progress." -ForegroundColor Green                                    
        }
        elseif($Argument -eq "sqlpassword")
        {
            $userInput= read-host -Prompt "`nEnter Sqlanywhere Admin Password" -AsSecureString
            $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
            $Global:SQLPassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()            
            $time = get-date -Format "yyyy MM dd HH:mm:ss"   
            Write-Host "`n$time : Validating sqlanywhere Password  : In Progress." -ForegroundColor Green             
        }
        elseif($Argument -eq "sianame")
        {
            $global:SiaName = hostname            
            $time = get-date -Format "yyyy MM dd HH:mm:ss" 
            Write-Host "`n$time : Validating sianame  : In Progress." -ForegroundColor Green                
        }
        $InputValidationStatus = Invoke-Expression "C:\ebid\ebid_input_validate\ebid_input_validate.ps1 $Argument"        
        if($InputValidationStatus -eq $true)
        {
            $Validation = $true
            return $true
        }
        else
        {
            if($Argument -eq "sianame")
            {
                $time = get-date -Format "yyyy MM dd HH:mm:ss"
                write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
                Write-Host "`n$time : Validating sianame  : failed, $InputValidationStatus." -ForegroundColor Red                                
                exit
            }
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
            write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
            Write-Host "`n$time : Validating $Argument  : failed, $InputValidationStatus. Please enter valid input" -ForegroundColor Red
            $ErrorCount += 1            
        }
    }    
    ErrorCountCheck $ErrorCount    
}

# ------------------------------------------------------------------------
#  Function to get user input for II
# ------------------------------------------------------------------------
function UpdateInstallIni()
{                        
    $global:NewInstallini = (Get-ChildItem C:\ebid\install -Filter *.ini -Recurse | % { $_.FullName })
    Set-ItemProperty $global:NewInstallini -name IsReadOnly -value $false    

    $regex = [regex] '(?m)^cmspassword=$'
    (Get-Content $global:NewInstallini) -replace $regex, "cmspassword=$global:NewCMSPassword" | Set-Content $global:NewInstallini

    $regex1 = [regex] '(?m)^clusterkey=$'
    (Get-Content $global:NewInstallini) -replace $regex1, "clusterkey=$global:ClusterKey" | Set-Content $global:NewInstallini

    $regex2 = [regex] '(?m)^lcmpassword=$'
    (Get-Content $global:NewInstallini) -replace $regex2, "lcmpassword=$global:LCMPassword" | Set-Content $global:NewInstallini

    $regex3 = [regex] '(?m)^sqlanywhereadminpassword=$'
    (Get-Content $global:NewInstallini) -replace $regex3, "sqlanywhereadminpassword=$global:SQLPassword" | Set-Content $global:NewInstallini

    $regex4 = [regex] '(?m)^productkey=$'
    (Get-Content $global:NewInstallini) -replace $regex4, "productkey=$global:ProducyKey" | Set-Content $global:NewInstallini

    $regex5 = [regex] '(?m)^sianame=eniq_node$'
    (Get-Content $global:NewInstallini) -replace $regex5, "sianame=$global:SiaName" | Set-Content $global:NewInstallini  
    
    $regex6 = "installdir=C:\Program Files (x86)\SAP BusinessObjects\"
    (Get-Content $global:NewInstallini) -replace [Regex]::Escape($regex6), "installdir=$global:InstallDirectory" | Set-Content $global:NewInstallini         
}

# Function to take input of eniq server
Function Eniqloginserver{
	$global:Eniqserver = Read-Host "`nEnter FQDN of ENIQ Server"
	$global:Eniqserver = $global:Eniqserver.Trim()
	IF($global:Eniqserver -eq "" )
	{
		Write-Host "`n[ ERROR ] : value should not be Null. Please enter appropriate value." -ForegroundColor Red
		Eniqloginserver
	}
	$global:NewInstallini = (Get-ChildItem C:\ebid\ebid_automation -Filter eniq.ini -Recurse | % { $_.FullName })
 
    Set-ItemProperty $global:NewInstallini -name IsReadOnly -value $false    

   $regex = [regex] '(?m)^eniqserver=$'
    (Get-Content $global:NewInstallini) -replace $regex, "eniqserver=$global:Eniqserver" | Set-Content $global:NewInstallini
}


Function EniqUserLogin{
	$global:EniqUsername = Read-Host "`nEnter Username of ENIQ Server"
	$global:EniqUsername = $global:EniqUsername.Trim()
	IF($global:EniqUsername -eq "" )
	{
		Write-Host "`n[ ERROR ] : value should not be Null. Please enter appropriate value." -ForegroundColor Red
		EniqUserLogin
	}
	$global:NewInstallini = (Get-ChildItem C:\ebid\ebid_automation -Filter eniq.ini -Recurse | % { $_.FullName })
 
    Set-ItemProperty $global:NewInstallini -name IsReadOnly -value $false    

    $regex1 = [regex] '(?m)^username=$'
    (Get-Content $global:NewInstallini) -replace $regex1, "username=$global:EniqUsername" | Set-Content $global:NewInstallini
}


Function Eniqdetails{
	$userInput= read-host -Prompt "`nEnter Password of ENIQ Server" -AsSecureString
            $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
            $global:NewEniqPassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()   
			#Write-Host($global:NewEniqPassword)
	IF($global:NewEniqPassword -eq "" )
	{
		Write-Host "`n[ ERROR ] : value should not be Null. Please enter appropriate value." -ForegroundColor Red
		Eniqdetails
	}
	$global:NewInstallini = (Get-ChildItem C:\ebid\ebid_automation -Filter eniq.ini -Recurse | % { $_.FullName })
 
    Set-ItemProperty $global:NewInstallini -name IsReadOnly -value $false    

    $regex2 = [regex] '(?m)^eniqpassword=$'
    (Get-Content $global:NewInstallini) -replace $regex2, "eniqpassword=$Global:NewEniqPassword" | Set-Content $global:NewInstallini
}




# ------------------------------------------------------------------------
#  Function to update housekeeping ini
# ------------------------------------------------------------------------
function UpdateHousekeepingini()
{     
    #$global:HouseKeepingini = (Get-ChildItem C:\ebid\housekeeping -Filter ebid_housekeeping.ini -Recurse | % { $_.FullName })
    Set-ItemProperty $global:HouseKeepingini -name IsReadOnly -value $false

    $regex = [regex] '(?m)^bi_install_dir=$'
    (Get-Content $global:HouseKeepingini) -replace $regex, "bi_install_dir=$global:InstallDirectory" | Set-Content $global:HouseKeepingini

    $regex1 = [regex] '(?m)^cmspassword=$'
    (Get-Content $global:HouseKeepingini) -replace $regex1, "cmspassword=$global:NewCMSPassword" | Set-Content $global:HouseKeepingini

    $regex2 = [regex] '(?m)^sqlanywhereadminpassword=$'
    (Get-Content $global:HouseKeepingini) -replace $regex2, "sqlanywhereadminpassword=$global:SQLPassword" | Set-Content $global:HouseKeepingini

    $regex3 = [regex] '(?m)^clusterkey=$'
    (Get-Content $global:HouseKeepingini) -replace $regex3, "clusterkey=$global:ClusterKey" | Set-Content $global:HouseKeepingini    
}

# ------------------------------------------------------------------------
#  Function to get certificate and housekeeping inputs
# ------------------------------------------------------------------------

function ErrorCountCheck($Count)
{    
    if($Count -gt 4)
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
        Write-Host "`n$time :  Wrong inputs attempts exceeded." -ForegroundColor Red
        $Script:ErrorCheck += 1 
    }
}

function GetExtraInputs()
{
    PrintDateTime
    "Asking user for SSL and Housekeeping inputs" >>$global:LogFile
    $EBIDMediaDrive = MountMedia $global:EBIDMedia
    "Media: $global:EBIDMedia is mounted in $EBIDMediaDrive" >>$global:LogFile
    $HouseKeepingFolder = $EBIDMediaDrive+"housekeeping" 
    if(test-Path "C:\ebid\housekeeping")
    {
        "Housekeeping folder already present and replacing the folder" >>$global:LogFile
        Get-ChildItem -Path "C:\ebid\housekeeping\*" -Recurse -File | % { $_.IsReadOnly=$False }
        Copy-Item $HouseKeepingFolder -Destination "C:\ebid\" -Recurse -Force
    }
    else
    {
        "Housekeeping folder is not present and copying" >>$global:LogFile
		Copy-Item $HouseKeepingFolder -Destination "C:\ebid\" -Recurse -Force        
    }
    Set-ItemProperty $global:HouseKeepingini -name IsReadOnly -value $false    
    $TempFile = "C:\ebid\TempPwd.ini"
    if(Test-Path -Path $TempFile)
    {
        Clear-Content -Path  $TempFile
    }
    if(Test-Path -Path "C:\Certificates\tomcatssl.p12")
    {
        "C:\certificates\tomcatssl.p12 file is present and Asking for Keystore password" >>$global:LogFile        
    }
    else
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"    
        Write-Host "`n$time :  CA signed certificates are not placed in C:\Certificates folder. Hence Configuring Self signed certificate" -ForegroundColor Green
        Write-Host "`n$time :  Please Enter below inputs for configuring self signed certificates"  -ForegroundColor Green                
		Add-Content -Path $TempFile -Value "SSL_Validity=825"                       
    }
    $ErrorCount = 0 
    $Validation = $false
    while(($ErrorCount -lt 5) -AND ($Validation  -ne $true))
    {        
        $KeystoreCheck = 0
		$userInput= read-host -Prompt "`nEnter Keystore Password for certificate" -AsSecureString
        $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
        $KeyStorePassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()
        $time = get-date -Format "yyyy MM dd HH:mm:ss"        
        if($KeyStorePassword -eq "")
        {
            Write-Host '`n$time :  Keystore Password should not be null or Value should not contain  " & < > space and tabspace' -ForegroundColor Red
            $ErrorCount += 1
        }
        else
        {
            if($KeyStorePassword.length -gt 5)
            {
	            $restricted_chars = @("`"","&","<",">"," ","`t")
	            foreach($restricted_char in $restricted_chars)
	            {                    
	            	if($KeyStorePassword.contains($restricted_char)) 
	            	{				                        
	            		$KeystoreCheck += 1
	            	} 
	            }
                if($KeystoreCheck -eq 0)
                {
                    $Validation = $true
                    Add-Content -Path $TempFile -Value "SSL_KeyPassword=$KeyStorePassword"
                }
                else
                {
                    Write-Host '`n$time :  Keystore Password should not contain " & < > space and tabspace Values' -ForegroundColor Red
                    $ErrorCount += 1
                }
            }
            else
            {
                Write-Host "`n$time :  Keystore Password length should be greater than 5" -ForegroundColor Red
                $ErrorCount += 1
            }
            
        }            
    }                         
    ErrorCountCheck $ErrorCount 
    $HousekeepingConfig = Read-Host "`nDo you want to configure Weekly Housekeeping Activity (Y/N)?"
    if(($HousekeepingConfig -eq "Yes") -or ($HousekeepingConfig -eq "Y"))
    {
        $ErrorCount = 0 
        $Validation = $false
        while(($ErrorCount -lt 5) -AND ($Validation  -ne $true))
        {
            $time = get-date -Format "yyyy MM dd HH:mm:ss"    
            Write-Host "`n$time :  Weekly Activity day value should be {Sun,Mon,Tue,Wed,Thu,Fri or Sat}" -ForegroundColor Green
            $WeeklyActivityDay = Read-Host "`nEnter Weekly Activity day for Housekeeping"
            if($ArrayDays -ccontains $WeeklyActivityDay -ne "True")
            {
                Write-Host "`n$time :  weekly_activity_day is not proper format" -ForegroundColor Red
               $ErrorCount += 1
            }
            else
            {
                $Validation = $true
                $regex = [regex] '(?m)^weekly_activity_day=$'
                (Get-Content $global:HouseKeepingini) -replace $regex, "weekly_activity_day=$WeeklyActivityDay" | Set-Content $global:HouseKeepingini
            }
        }
        ErrorCountCheck $ErrorCount
        $ErrorCount = 0
        $Validation = $false 
        while(($ErrorCount -lt 5) -AND ($Validation  -ne $true))
        {
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
            $BILogRetention = Read-Host "`nEnter the number of days of Log Retention for BI Logs"
            if(($BILogRetention -eq "") -OR ($BILogRetention -match '^[0-9]+$' -ne "True")) 
            {
                Write-Host "`n$time :  Bi log retention value should not be null or Value should be integer" -ForegroundColor Red
                $ErrorCount += 1   
            }
            else
            {
                $Validation = $true
                $regex1 = [regex] '(?m)^bi_log_retention=$'
                (Get-Content $global:HouseKeepingini) -replace $regex1, "bi_log_retention=$BILogRetention" | Set-Content $global:HouseKeepingini
            }
        }
        ErrorCountCheck $ErrorCount
        $ErrorCount = 0 
        $Validation = $false
        while(($ErrorCount -lt 5) -AND ($Validation  -ne $true))
        {
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
            $HousekeepingRetention = Read-Host "`nEnter the number of days of Log Retention for Housekeeping Log"
            if(($HousekeepingRetention -eq "") -OR ($HousekeepingRetention -match '^[0-9]+$' -ne "True")) 
            {
                Write-Host "`n$time :  Housekeeping log retention value should not be null or Value should be integer" -ForegroundColor Red
                $ErrorCount += 1   
            }
            else
            {
                $Validation = $true
                $regex2 = [regex] '(?m)^housekeeping_log_retention=$'
                (Get-Content $global:HouseKeepingini) -replace $regex2, "housekeeping_log_retention=$HousekeepingRetention" | Set-Content $global:HouseKeepingini 
            }
        }
        ErrorCountCheck $ErrorCount
        $ErrorCount = 0 
        $Validation = $false
        while(($ErrorCount -lt 5) -AND ($Validation  -ne $true))
        {
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
            $TomcatRetention = Read-Host "`nEnter the number of days of Log Retention for Tomcat Log"    
            if(($TomcatRetention -eq "") -OR ($TomcatRetention -match '^[0-9]+$' -ne "True")) 
            {
                Write-Host "`n$time :  tomcat log retention value should not be null or Value should be integer" -ForegroundColor Red
                $ErrorCount += 1   
            }
            else
            {
                $Validation = $true
                $regex2 = [regex] '(?m)^tomcat_log_backup_retention=$'
                (Get-Content $global:HouseKeepingini) -replace $regex2, "tomcat_log_backup_retention=$TomcatRetention" | Set-Content $global:HouseKeepingini
            }
        } 
        ErrorCountCheck $ErrorCount            
    }
    #Write-Host "Error count $Script:ErrorCheck"
    if($Script:ErrorCheck -gt 0)           
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
        Write-Host "`n$time :  There are errors in entered inputs. Please check document for valid inputs and run the script." -ForegroundColor Red
        Exit
    }
}

# ------------------------------------------------------------------------
#  Function to get RDP certificate inputs
# ------------------------------------------------------------------------
#>

<#
function GetRDPInputs()
{ 
	PrintDateTime
	"Asking user for RDP certificate inputs" >>$global:LogFile
	$TempFile = "C:\ebid\TempPwd.ini"
    <# if(Test-Path -Path $TempFile)
    {
        Clear-Content -Path  $TempFile
    } #>
	#getting input for RDP
#>	

<#
  if(Test-Path -Path "C:\Certificates\rdp.p12")
    {
        "C:\certificates\rdp.p12 file is present and Asking for Certificate password" >>$global:LogFile   
		
		$ErrorCount = 0 
		$Validation = $false
		while(($ErrorCount -lt 5) -AND ($Validation  -ne $true))
		{        
			$PassCheck = 0
			$userInput= read-host -Prompt "`nEnter Certificate Password for RDP" -AsSecureString
			$bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
			$CertPassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()
			$time = get-date -Format "yyyy MM dd HH:mm:ss"        
			if($CertPassword -eq "")
			{
				Write-Host '`n$time :  Certificate Password should not be null or Value should not contain  " & < > space and tabspace' -ForegroundColor Red
				$ErrorCount += 1
			}
			else
			{
				if($CertPassword.length -gt 5)
				{
					$restricted_chars = @("`"","&","<",">"," ","`t")
					foreach($restricted_char in $restricted_chars)
					{                    
						if($CertPassword.contains($restricted_char)) 
						{				                        
							$PassCheck += 1
						} 
					}
					if($PassCheck -eq 0)
					{
						$Validation = $true
						Add-Content -Path $TempFile -Value "RDP_CertPassword=$CertPassword"
					}
					else
					{
						Write-Host '`n$time :  Certificate Password should not contain " & < > space and tabspace Values' -ForegroundColor Red
						$ErrorCount += 1
					}
				}
				else
				{
					Write-Host "`n$time :  Certificate Password length should be greater than 5" -ForegroundColor Red
					$ErrorCount += 1
				}
				
			}            
		} 
		ErrorCountCheck $ErrorCount	
	}
	else
    {
        $time = get-date -Format "yyyy MM dd HH:mm:ss"    
        Write-Host "`n$time :  CA signed certificate for RDP is not placed in C:\Certificates folder. Hence refer Ericsson Network IQ Security Admin Guide document to perform self-signed certificate removal for RDP manually. " -ForegroundColor Green    
		Add-Content -Path $TempFile -Value "RDP_CertPassword=No"
    }	
}

# ------------------------------------------------------------------------
#  Function to Find the Health Status of the server Now
# ------------------------------------------------------------------------

Function CheckBIServerStatusNow()
{
	PrintDateTime
	"`nChecking the Health Status of Bi Server Now" >>$global:LogFile
	try
	{		
		$global:StoppedServer = 100
		$global:DisabledServer = 100
		$global:RunningServer = 100
		$global:enabledServer = 100
		$global:WaitingTime = 0
		
		while((($global:StoppedServer -ne 0) -OR ($global:DisabledServer -ne 0) -OR ($global:RunningServer -ne $global:enabledServer)) -AND ($global:WaitingTime -le 40))
		{
			Start-Sleep  -seconds 25
            $global:WaitingTime = $global:WaitingTime + 1
			
			$obj1 = & $global:CCMDirectory -display  all -username Administrator -password $global:CmsPassword
			$obj1 >>$global:LogFile
			if($obj -like "*Unable*")
			{
				"Unable to login to SIA and checking again" >>$global:LogFile
			}
			else{								
			$MatchesRunning = Select-String -InputObject $obj1 -Pattern " Running" -AllMatches 
			$global:RunningServer=$MatchesRunning.Matches.Count
	
			$MatchesFailed =  Select-String -InputObject $obj1 -Pattern " Failed" -AllMatches 
			$global:FailedServer = $MatchesFailed.Matches.Count
	
			$MatchesStarting =  Select-String -InputObject $obj1 -Pattern " Starting" -AllMatches 
			$global:StartServer = $MatchesStarting.Matches.Count
	
			$MatchesStopped = Select-String -InputObject $obj1 -Pattern " Stopped" -AllMatches 
			$global:StoppedServer=$MatchesStopped.Matches.Count
	
			$MatchesEnabled = Select-String -InputObject $obj1 -Pattern " Enabled" -AllMatches 
			$global:EnabledServer=$MatchesEnabled.Matches.Count 
	
			$MatchesDisabled = Select-String -InputObject $obj1 -Pattern " Disabled" -AllMatches 
			$global:DisabledServer=$MatchesDisabled.Matches.Count
			
			if($global:WaitingTime -ge 40)
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] Unable to restart servers after 10minutes also. Please start servers manually and execute the script again. `n" -ForegroundColor Red		
				Exit
			}
			}
		}
		
		if($StoppedServer -ne 0)
		{        
			"Some servers are stopped." >>$global:LogFile
		}
		if($StartServer -ne 0)
		{
			"Some servers are in starting state." >>$global:LogFile
		}
		if($DisabledServer -ne 0)
		{        
			"Some servers are Disabled." >>$global:LogFile
		}
		if($RunningServer -ne $enabledServer)
		{       
			"Some servers are not running or enabled." >>$global:LogFile
		}   
		if($FailedServer -ne 0) 
		{			
			"Some servers are in failed state." >>$global:LogFile
		}
		if(($StoppedServer -eq 0) -AND ($DisabledServer -eq 0) -AND ($RunningServer -eq $enabledServer))
		{
			if($RunningServer -gt 0)
			{
				$global:ServersStatus=$True
				"All servers are running" >>$global:LogFile
				CheckDiskSpace
			}
		}
		if(($global:ServersStatus -ne $True) -or ($global:DiskSpaceStatus -ne $True))
		{
			"`nServer Heath Check Failed" >>$global:LogFile
			"`nChecking if CentralManagementServer is running" >>$global:LogFile
			$server=$global:ComputerName+".CentralManagementServer"
			$Description = "Description: Central Management Server"
			#$obj1 = &"$global:CCMDirectory"  -display -username Administrator -password $global:CmsPassword
			$pattern=("Server Name: "+$server+"(.*?)"+$Description)
			$Match = [regex]::match($obj1, $pattern,"IgnoreCase") 	
			if($Match.Success)           
			{	
				"`nCentralManagementServer is available" >>$global:LogFile
				$ServerStatus=$Match.Value
				$ServerStatus.trim() >>$global:LogFile
				$seperator = " "
				$ServerStatus_Check = $ServerStatus -split  $seperator
				if($ServerStatus_Check.trim() -and $ServerStatus_Check[4] -eq 'Running' -and $ServerStatus_Check[6] -eq 'Enabled')
				{  
					"`nCentralManagementServer is running" >>$global:LogFile
					"`nChecking if InputFileRepository is running" >>$global:LogFile				
					$server1=$global:ComputerName+".InputFileRepository"
					$Description1 = "Description: Input File Repository Server"
					#$obj3 = &"$global:CCMDirectory"  -display -username Administrator -password $global:CmsPassword
					$pattern=("Server Name: "+$server1+"(.*?)"+$Description1)
					$Match1 = [regex]::match($obj1, $pattern,"IgnoreCase") 
					if($Match1.Success)           
					{
						"`nInputFileRepository is available" >>$global:LogFile
						$ServerStatus1=$Match1.Value
						$ServerStatus1.trim()  >>$global:LogFile
						$seperator1 = " "
						$ServerStatus_Check1 = $ServerStatus1 -split  $seperator1
						if($ServerStatus_Check1.trim() -and $ServerStatus_Check1[4] -eq 'Running' -and $ServerStatus_Check1[6] -eq 'Enabled')
						{
							"`InputFileRepository is running" >>$global:LogFile
							"`nChecking if OutputFileRepository is running" >>$global:LogFile							
							$server2=$global:ComputerName+".OutputFileRepository"
							$Description2 = "Description: Output File Repository Server"
							#$obj4 = &"$global:CCMDirectory"  -display -username Administrator -password $global:CmsPassword
							$pattern=("Server Name: "+$server2+"(.*?)"+$Description2)
							$Match2 = [regex]::match($obj1, $pattern,"IgnoreCase")
							if($Match2.Success)           
							{
								"`nOutputFileRepository is available" >>$global:LogFile
								$ServerStatus1=$Match2.Value
								$ServerStatus1.trim()  >>$global:LogFile
								$seperator1 = " "
								$ServerStatus_Check1 = $ServerStatus1 -split  $seperator1
								if($ServerStatus_Check1.trim() -and $ServerStatus_Check1[4] -eq 'Running' -and $ServerStatus_Check1[6] -eq 'Enabled')
								{
									"`OutputFileRepository is running" >>$global:LogFile
									$Answer= read-host "`nFew Servers are not running do you want to proceed with upgrade? (Y/N)"
									if ($Answer -eq "Y")
									{
										"`User chose to continue irrespective of server status" >>$global:LogFile
										$global:ServersStatus=$True
										CheckDiskSpace
										if(($global:ServersStatus -ne $True) -or ($global:DiskSpaceStatus -ne $True))
										{
											$time = get-date -Format "yyyy MM dd HH:mm:ss"
											write-host "`n$time : [ERROR] Server Health Check : Failed. Check $global:LogFile for more details" -ForegroundColor Red
											Exit
										}
										else
										{
											$time = get-date -Format "yyyy MM dd HH:mm:ss"
											write-host "`n$time : Server Health Check : Successful. Proceeding to next stage.." -ForegroundColor Green
											$time = get-date -Format "yyyy MM dd HH:mm:ss"
											write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
										}
									}	
									elseif ($Answer -eq "N")
									{
										"`User chose to quit because of server status" >>$global:LogFile
										$time = get-date -Format "yyyy MM dd HH:mm:ss"
										write-host "`n$time : [ERROR] Exiting Script." -ForegroundColor Red
										EXIT
									}	
									else
									{
										"`User gave an invalid input for server status" >>$global:LogFile
										$time = get-date -Format "yyyy MM dd HH:mm:ss"
										write-host "`n$time : [ERROR] Invalid Input." -ForegroundColor Red
										Exit										
									}	
								}
								else
								{
									"`nOutputFileRepository is not running" >>$global:LogFile
									$time = get-date -Format "yyyy MM dd HH:mm:ss"
									write-host "`n$time : [ERROR] Server Heath Check : Failed. Check $global:LogFile for more details" -ForegroundColor Red
									Exit
								}
							}
							else
							{
								"`nOutputFileRepository is not available" >>$global:LogFile
								$time = get-date -Format "yyyy MM dd HH:mm:ss"
								write-host "`n$time : [ERROR] Server Heath Check : Failed. Check $global:LogFile for more details" -ForegroundColor Red
								Exit
							}
						}
						else
						{
							"`InputFileRepository is not running" >>$global:LogFile
							$time = get-date -Format "yyyy MM dd HH:mm:ss"
							write-host "`n$time : [ERROR] Server Heath Check : Failed. Check $global:LogFile for more details" -ForegroundColor Red
							Exit
						}
					}
					else
					{
						"`nInputFileRepository is not available" >>$global:LogFile
						$time = get-date -Format "yyyy MM dd HH:mm:ss"
						write-host "`n$time : [ERROR] Server Heath Check : Failed. Check $global:LogFile for more details" -ForegroundColor Red
						Exit
					}
				}
				else
				{
					"`nCentralManagementServer is not running" >>$global:LogFile
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : [ERROR] Server Heath Check : Failed. Check $global:LogFile for more details" -ForegroundColor Red
					Exit
				}
			}
			else
			{
				"`nCentralManagementServer is not available" >>$global:LogFile
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] Server Heath Check : Failed. Check $global:LogFile for more details" -ForegroundColor Red
				Exit
			}
		}
		else
		{
			"`nServer Health is fine. Proceeding to next stage" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : Server Health Check : Successful. Proceeding to next stage.." -ForegroundColor Green
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckBIServerStatusNow function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}	
}

# ------------------------------------------------------------------------
#  Function to Find the Health Status of the server From Housekeeping Report
# ------------------------------------------------------------------------

Function CheckHealthStatusFromReport()
{
	"`nChecking the Health Status of Bi Server From Housekeeping Report" >>$global:LogFile
	$HousekeepingReportArrray = @()
	$HousekeepingReportArrray = Get-ChildItem  -Path $global:HousekeepingReport | Where{$_.LastWriteTime -gt (Get-Date).AddDays(-1)}
	$FileToRead = $global:HousekeepingReportPath+$HousekeepingReportArrray[0].Name
	$html = New-Object -ComObject "HTMLFile" 
	$html.IHTMLDocument2_write($(Get-Content $FileToRead -raw)) 
	$html.all.tags("A") | % innerText
	
}

# ------------------------------------------------------------------------
#  Function to Check Disk Space 
# ------------------------------------------------------------------------

Function CheckDiskSpace()
{
	PrintDateTime
	"`nChecking Disk Space Started " >>$global:LogFile   
	try
	{		
		"`nDisk Space Information For $global:BiInstallDirLetter Drive"  >>$global:LogFile
		$DiskDetails = Get-WmiObject -Class Win32_logicaldisk -Filter "DeviceID='$global:BiInstallDirLetter'"
		$BiDirTotalspace =[math]::Round(($DiskDetails.Size)/1gb,2)
		$BiDirFreespace = [math]::Round(($DiskDetails.FreeSpace)/1gb,2)
		"`nCapacity $BiDirTotalspace gb and Freespace $BiDirFreespace gb"   >>$global:LogFile
		if( $BiDirFreespace -ge 16)
		{
			$global:DiskSpaceStatus = $True
			"`nSufficient Space Available for Upgrade"   >>$global:LogFile
		}
		else
		{		
			"`nInSufficient Space for Upgrade. Cleanup Drive space and try again."   >>$global:LogFile
			Write-Host "`nInSufficient Space for Upgrade. Cleanup Drive space and try again." -ForegroundColor Red
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckDiskSpace function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}	
   
}

# ------------------------------------------------------------------------
#  Function to Mount Media
# ------------------------------------------------------------------------

Function MountMedia($Media)
{
	PrintDateTime
	"Mounting media: $Media" >>$global:LogFile
	try
	{			
		if((Get-DiskImage -ImagePath $Media).Attached)
		{
			"Media: $Media already mounted" >>$global:LogFile
			$DriveLetter = (Get-DiskImage -ImagePath $Media | Get-Volume).DriveLetter
			$DriveLetter = $DriveLetter + ":\"      
		}
		else
		{
			"Media: $Media Not mounted and mounting..." >>$global:LogFile
			$DriveLetter = (Mount-DiskImage -ImagePath $Media -PassThru | Get-Volume).DriveLetter        
			$DriveLetter = $DriveLetter + ":\"        
		}  
		"Media: $Media is mounted in $DriveLetter" >>$global:LogFile
		return $DriveLetter
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in MountMedia function for $Media" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to mount and copy the upgrade ini files
# ------------------------------------------------------------------------

Function CopyIniFiles()
{
	PrintDateTime
	"`nMounting and Copying Ini file" >>$global:LogFile
	try
	{
		ReadBIVersion
		if($global:BiServerFound -eq $true)
		{
			$global:ServerMediaDrive = MountMedia($global:ServerMedia)
			$global:EBIDMediaDrive = MountMedia($global:EBIDMedia)
			
			$bi_inventory = $bi_install_dir + "\InstallData\inventory.txt"
			$license_required = "True"
			if (Test-Path -Path $bi_inventory)
			{
				$bi_ver = Get-Content $bi_inventory
				foreach ($line in $bi_ver)
				{
					if ($line -match "4.3")
					{
						"Server contains BIS 4.3" >>$log
						$license_required = "False"
					}
				}
			}

			if (($license_required -eq "True") -and (Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
			{			
				(Get-Content $global:MasterScriptConfigFile) -replace '^product_key_required =.+$', "product_key_required = Yes" | Set-Content $global:MasterScriptConfigFile
				$global:ProductKey = Read-Host "`nEnter Product Key"
				UpdateServerIni	
			}
			else
			{
				"Product/License key update is not required as server already has BI 4.3" >>$global:LogFile
				UpdateServerIni
			}					
		}
		elseif($global:BiClientFound -eq $true)
		{
			$global:ClientMediaDrive = MountMedia($global:ClientMedia)
			CopyClientIni
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopyIniFiles function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# -----------------------------------------------------------------------------------
#  Function to Backup LegalNotice.ini
# -----------------------------------------------------------------------------------

function Backup_LegalNoticeFiles()
{
	PrintDateTime
	$Path_LegalNotice = "C:\ebid\install_config\LegalNotice.ini"
	$Backup_LegalNotice = "C:\ebid\"

	$Check_Backup_LegalNotice = "C:\ebid\LegalNotice.ini"
	if (Test-Path -Path $Check_Backup_LegalNotice)
	{
		"'LegalNotice.ini' backup is present in $Backup_LegalNotice directory" >>$global:LogFile
	}
	else
	{
		"'LegalNotice.ini' backup is not present in $Backup_LegalNotice directory" >>$global:LogFile
		if (Test-Path -Path $Path_LegalNotice)
		{
			"'LegalNotice.ini' file is found in C:\ebid\install_config\ directory" >>$global:LogFile
			
			Copy-Item $Path_LegalNotice -Destination $Backup_LegalNotice -Force
			"Copied 'LegalNotice.ini' file to $Backup_LegalNotice directory" >>$global:LogFile
		}
		else
		{
			"$Path_LegalNotice is not present" >>$global:LogFile
		}
	}
}

# -----------------------------------------------------------------------------------
#  Function to Backup Admin UI Legal Notice
# -----------------------------------------------------------------------------------

function Backup_LegalNotice_AdminUI()
{
	PrintDateTime
	$bi_install_dir_temp = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora' -Name Path).Path
	
	# CMC
	$Backup_CMC_web = "C:\ebid\install_config\temp_LegalWarning\CMC\"
	$Backup_CMC_weborigin = "C:\ebid\install_config\temp_LegalWarning\CMC\web-origin\"

	$Path_CMCApp = $bi_install_dir_temp + "\tomcat\webapps\BOE\WEB-INF\eclipse\plugins\webpath.CmcApp\"
	$Path_CMC_web = $Path_CMCApp + "web\logon.jsp"
	$Path_CMC_weborigin = $Path_CMCApp + "web-origin\logon.jsp"
	
	if ((Test-Path -Path $Backup_CMC_web) -and (Test-Path -Path $Backup_CMC_weborigin))
	{
		"Relevant files of 'webpath.CMCApp' are present in C:\ebid\install_config\temp_LegalWarning\CMC\ directory" >>$global:LogFile
	}
	else
	{
		"Relevant files of 'webpath.CmcApp' are not present in in C:\ebid\install_config\temp_LegalWarning\CMC\ directory" >>$global:LogFile
		"Checking if 'webpath.CmcApp' is present..." >>$global:LogFile

		if (Test-Path -Path $Path_CMCApp)
		{
			"'webpath.CmcApp' directory is found" >>$global:LogFile
			
			if (Test-Path -Path $Path_CMC_web)
			{
				"Original CMC 'logon.jsp' is found" >>$global:LogFile
				New-Item -ItemType directory -Path $Backup_CMC_web -erroraction 'silentlycontinue' | out-null

				Copy-Item $Path_CMC_web -Destination $Backup_CMC_web -Force
				"Copied original CMC 'logon.jsp' file to $Backup_CMC_web directory" >>$global:LogFile

				if (Test-Path -Path $Path_CMC_weborigin)
				{
					"Backup of CMC 'logon.jsp' is found" >>$global:LogFile
					New-Item -ItemType directory -Path $Backup_CMC_weborigin -erroraction 'silentlycontinue' | out-null
					
					Copy-Item $Path_CMC_weborigin -Destination $Backup_CMC_weborigin -Force
					"Copied backup CMC 'logon.jsp' file to $Backup_CMC_weborigin directory" >>$global:LogFile
				}
				else
				{
					"'logon.jsp' backup is not found in $Path_CMCApp\web-origin\ directory." >>$global:LogFile
					Remove-Item "C:\ebid\install_config\temp_LegalWarning\CMC\" -Recurse
					"Removed C:\ebid\install_config\temp_LegalWarning\CMC\ directory" >>$global:LogFile
				}
			}
			else
			{
				"'logon.jsp' is not found in $Path_CMCApp\web\ directory." >>$global:LogFile
			}
		}
		else
		{
			"$Path_CMCApp is not present" >>$global:LogFile
		}
	}

	# BI Launch Pad
	$Backup_biInfoView_web = "C:\ebid\install_config\temp_LegalWarning\BI\"
	$Backup_biInfoView_weborigin = "C:\ebid\install_config\temp_LegalWarning\BI\web-origin\"

	$Path_biInfoView = $bi_install_dir_temp + "\tomcat\webapps\BOE\WEB-INF\eclipse\plugins\webpath.InfoView\"
	$Path_biInfoView_web = $Path_biInfoView + "web\logon.jsp"
	$Path_biInfoView_weborigin = $Path_biInfoView + "web-origin\logon.jsp"
	
	if ((Test-Path -Path $Backup_biInfoView_web) -and (Test-Path -Path $Backup_biInfoView_weborigin))
	{
		"Relevant files of 'webpath.InfoView' are present in C:\ebid\install_config\temp_LegalWarning\BI\ directory" >>$global:LogFile
	}
	else
	{
		"Relevant files of 'webpath.InfoView' are not present in in C:\ebid\install_config\temp_LegalWarning\BI\ directory" >>$global:LogFile
		"Checking if 'webpath.InfoView' is present..." >>$global:LogFile

		if (Test-Path -Path $Path_biInfoView)
		{
			"'webpath.InfoView' directory is found" >>$global:LogFile
			
			if (Test-Path -Path $Path_biInfoView_web)
			{
				"Original BI 'logon.jsp' is found." >>$global:LogFile
				New-Item -ItemType directory -Path $Backup_biInfoView_web -erroraction 'silentlycontinue' | out-null

				Copy-Item $Path_biInfoView_web -Destination $Backup_biInfoView_web -Force
				"Copied original BI 'logon.jsp' file to $Backup_biInfoView_web directory" >>$global:LogFile

				if (Test-Path -Path $Path_biInfoView_weborigin)
				{
					"Backup of BI 'logon.jsp' is found" >>$global:LogFile
					New-Item -ItemType directory -Path $Backup_biInfoView_weborigin -erroraction 'silentlycontinue' | out-null
					
					Copy-Item $Path_biInfoView_weborigin -Destination $Backup_biInfoView_weborigin -Force
					"Copied backup BI 'logon.jsp' file to $Backup_biInfoView_weborigin directory" >>$global:LogFile
				}
				else
				{
					"'logon.jsp' backup is not found in $Path_biInfoView\web-origin\ directory." >>$global:LogFile
					Remove-Item "C:\ebid\install_config\temp_LegalWarning\BI\" -Recurse
					"Removed C:\ebid\install_config\temp_LegalWarning\BI\ directory" >>$global:LogFile
				}
			}
			else
			{
				"'logon.jsp' is not found in $Path_biInfoView\web\ directory." >>$global:LogFile
			}
		}
		else
		{
			"$Path_biInfoView is not present" >>$global:LogFile
		}
	}

	# Fiori BI
	$Backup_FioriJS_web = "C:\ebid\install_config\temp_LegalWarning\FioriBI\"
	$Backup_FioriJS_weborigin = "C:\ebid\install_config\temp_LegalWarning\FioriBI\web-origin\"

	$Path_FioriJS = $bi_install_dir_temp + "\tomcat\webapps\BOE\WEB-INF\eclipse\plugins\webpath.FioriBI\web\com\sap\fioribi\modules\logonpage\"
	$Path_FioriJS_web = $Path_FioriJS + "LogonpageView.view.js"
	$Path_FioriJS_weborigin = $Path_FioriJS + "web-origin\LogonpageView.view.js"
	
	if ((Test-Path -Path $Backup_FioriJS_web) -and (Test-Path -Path $Backup_FioriJS_weborigin))
	{
		"Relevant files of 'webpath.FioriBI' are present in C:\ebid\install_config\temp_LegalWarning\FioriBI\ directory" >>$global:LogFile
	}
	else
	{
		"Relevant files of 'webpath.FioriBI' are not present in in C:\ebid\install_config\temp_LegalWarning\FioriBI\ directory" >>$global:LogFile
		"Checking if 'webpath.FioriBI' is present..." >>$global:LogFile

		if (Test-Path -Path $Path_FioriJS)
		{
			"'webpath.FioriBI' directory is found" >>$global:LogFile
			
			if (Test-Path -Path $Path_FioriJS_web)
			{
				"Original Fiori BI 'LogonpageView.view.js' is found." >>$global:LogFile
				New-Item -ItemType directory -Path $Backup_FioriJS_web -erroraction 'silentlycontinue' | out-null

				Copy-Item $Path_FioriJS_web -Destination $Backup_FioriJS_web -Force
				"Copied original Fiori BI 'LogonpageView.view.js' file to $Backup_FioriJS_web directory" >>$global:LogFile

				if (Test-Path -Path $Path_FioriJS_weborigin)
				{
					"Backup of Fiori BI 'LogonpageView.view.jsp' is found" >>$global:LogFile
					New-Item -ItemType directory -Path $Backup_FioriJS_weborigin -erroraction 'silentlycontinue' | out-null
					
					Copy-Item $Path_FioriJS_weborigin -Destination $Backup_FioriJS_weborigin -Force
					"Copied backup Fiori BI 'LogonpageView.view.js' file to $Backup_FioriJS_weborigin directory" >>$global:LogFile
				}
				else
				{
					"'LogonpageView.view.js' backup is not found in $Path_FioriJS\web-origin\ directory." >>$global:LogFile
					Remove-Item "C:\ebid\install_config\temp_LegalWarning\FioriBI\" -Recurse
					"Removed C:\ebid\install_config\temp_LegalWarning\FioriBI\ directory" >>$global:LogFile
				}
			}
			else
			{
				"'LogonpageView.view.js' is not found in $Path_FioriJS\web\ directory." >>$global:LogFile
			}
		}
		else
		{
			"$Path_FioriJS is not present" >>$global:LogFile
		}
	}
}

# -----------------------------------------------------------------------------------
#  Function to Restore LegalNotice.ini
# -----------------------------------------------------------------------------------

function Restore_LegalNoticeFiles()
{
	PrintDateTime
	$Path_LegalNotice = "C:\ebid\LegalNotice.ini"
	$Replace_LegalNotice = "C:\ebid\install_config\"
	
	if (Test-Path -Path $Path_LegalNotice)
	{
		"'LegalNotice.ini' file backup is found" >>$global:LogFile
		
		Copy-Item $Path_LegalNotice -Destination $Replace_LegalNotice -Force
		"Copied 'LegalNotice.ini' file to $Replace_LegalNotice directory" >>$global:LogFile
	}
	else
	{
		"Backup of 'LegalNotice.ini' is not present" >>$global:LogFile
	}
}

# -----------------------------------------------------------------------------------
#  Function to Copy Latest Install Config Files
# -----------------------------------------------------------------------------------
Function CopylatestInstallConfig()
{
	PrintDateTime
	try
	{
		$destination_Directory = "C:\ebid"
		$global:EBIDMediaDrive = MountMedia($global:EBIDMedia)
		
		Backup_LegalNoticeFiles
		Backup_LegalNotice_AdminUI
		$file_To_Be_Copied = ($global:EBIDMediaDrive + $global:InstallConfigPath)
		copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
		Restore_LegalNoticeFiles
		
		Get-ChildItem -Path "C:\ebid\install_config\*" -Recurse -File | % { $_.IsReadOnly=$False }
		if (test-path -Path ($destination_Directory+"\"+$global:InstallConfigPath))
		{
			"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		}
		else
		{
			"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopylatestInstallConfig function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}



# -----------------------------------------------------------------------------------
#  Function to Fetch BI version from ini file
# -----------------------------------------------------------------------------------

Function ReadBIVersion()
{
    PrintDateTime 
	"Reading inputs"  >>$global:LogFile	
	try
	{		
		foreach($line in Get-Content $global:MasterScriptConfigFile ) 
		{        
			if($line -match "bi_version =")
			{            
				$LineSplit = "$line".split("=",2)
				$global:BiVersion = $LineSplit[1].Trim()
				$HasValue = NullCheck $global:BiVersion "BI version"
				If($HasValue -eq $False)
				{
					"BiVersion is not available" >>$global:LogFile
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : BiVersion is not updated in $global:MasterScriptConfigFile" -ForegroundColor Red
					Exit
				}
				else
				{
					"BiVersion is available" >>$global:LogFile
				}
				"version is $global:BiVersion" >>$global:LogFile	
			}
			else
			{
				"no match" >>$global:LogFile
			}
		}		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in ReadBIVersion function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}  
}

# ------------------------------------------------------------------------
#  Function to Update the upgrade Server ini file
# ------------------------------------------------------------------------

Function UpdateServerIni()
{
	PrintDateTime
	"`nCopying and updating Server Ini file" >>$global:LogFile
	$global:BiVersion >>$global:LogFile
	try
	{
		[regex]$pattern = "_"
		$global:BiVersionIni = $pattern.replace($global:BiVersion, "", 1) 
		$global:UpgradeIniPath = "ebid_scripts\ebid_" + $global:BiVersionIni + "_server_upgrade.ini"
		$global:UpgradeIniPathToCopy = $global:ServerMediaDrive + $global:UpgradeIniPath	
		$global:ServerUpgradeIni = $global:UpgradeFolderPath + "\ebid_" +$global:BiVersionIni+ "_server_upgrade.ini" 
		$global:LicenseUpdatePath = "C:\ebid\update_license"
		$global:UpdateLicenseFileToCopy = $global:EBIDMediaDrive + "\update_license"
		if(Test-Path $global:UpgradeFolderPath)
		{
			"`nUpgrade Folder is already created" >>$global:LogFile
			Remove-Item -Path "C:\ebid\upgrade" -Force -recurse >>$global:LogFile
			New-Item C:\ebid\upgrade -ItemType Directory | Out-Null
		}
		else
		{
			New-Item C:\ebid\upgrade -ItemType Directory | Out-Null
		}
		if(Test-Path $global:UpgradeIniPathToCopy)
		{
			"`nUpgrade ini is present" >>$global:LogFile
			if(Test-Path $global:ServerUpgradeIni)
			{
				"`n$global:ServerUpgradeIni is present" >>$global:LogFile
			}
			else
			{
				Copy-Item $global:UpgradeIniPathToCopy "$global:UpgradeFolderPath"
			}
			
		$bi_inventory = $bi_install_dir + "\InstallData\inventory.txt"
		$license_required = "True"
		if (Test-Path -Path $bi_inventory)
		{
			$bi_ver = Get-Content $bi_inventory
			foreach ($line in $bi_ver)
			{
				if ($line -match "4.3")
				{
					"Server contains BIS 4.3" >>$log
					$license_required = "False"
				}
			}
		}

		if (($license_required -eq "True") -and (Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
		{
			(Get-Content $global:MasterScriptConfigFile) -replace '^product_key_required =.+$', "product_key_required = Yes" | Set-Content $global:MasterScriptConfigFile
			
			if(Test-Path $global:LicenseUpdatePath)
			{
				"`nUpdate license ini is present" >>$global:LogFile
				$global:NewLicenseini = (Get-ChildItem C:\ebid\update_license -Filter *.ini -Recurse | % { $_.FullName })
				Set-ItemProperty $global:NewLicenseini -name IsReadOnly -value $false
			}
			else
			{
				Copy_Folder -source_Directory $global:UpdateLicenseFileToCopy -destination_Directory "C:\ebid"
				"update_license folder copied" >>$global:LogFile
				$global:NewLicenseini = (Get-ChildItem C:\ebid\update_license -Filter *.ini -Recurse | % { $_.FullName })
				Set-ItemProperty $global:NewLicenseini -name IsReadOnly -value $false
			}
		}
		else
		{
			"Product/License key update is not required as server already has BI 4.3" >>$global:LogFile
		}
			$regex = [regex] '(?m)^remotecmsadminpassword=$'
			Set-ItemProperty $global:ServerUpgradeIni -name IsReadOnly -value $false
			(Get-Content $global:ServerUpgradeIni) -replace $regex, "remotecmsadminpassword=$global:cmspassword" | Set-Content $global:ServerUpgradeIni
			$regex2 = [regex] '(?m)^remotecmsname=eniq_node$'
			(Get-Content $global:ServerUpgradeIni) -replace $regex2, "remotecmsname=$global:ComputerName" | Set-Content $global:ServerUpgradeIni
			
			$bi_inventory = $bi_install_dir + "\InstallData\inventory.txt"
			$license_required = "True"
			if (Test-Path -Path $bi_inventory)
			{
				$bi_ver = Get-Content $bi_inventory
				foreach ($line in $bi_ver)
				{
					if ($line -match "4.3")
					{
						"Server contains BIS 4.3" >>$log
						$license_required = "False"
					}
				}
			}

			if (($license_required -eq "True") -and (Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
			{	
				(Get-Content $global:MasterScriptConfigFile) -replace '^product_key_required =.+$', "product_key_required = Yes" | Set-Content $global:MasterScriptConfigFile
				$regex3 = [regex] '(?m)^productkey=$'
				(Get-Content $global:NewLicenseini) -replace $regex3, "productkey=$global:ProductKey" | Set-Content $global:NewLicenseini
			}
			else
			{
				"Product/License key update is not required as server already has BI 4.3" >>$global:LogFile
			}			
		}
		else
		{
			"$global:UpgradeIniPathToCopy is missing" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			EXIT
		}		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in UpdateServerIni function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to copy the upgrade client ini file
# ------------------------------------------------------------------------

Function CopyClientIni()
{
	PrintDateTime
	"`nCopying Client Ini file" >>$global:LogFile
	try
	{
		[regex]$pattern = "_"
		$global:BiVersionIni = $pattern.replace($global:BiVersion, "", 1) 
		$global:UpgradeIniPathClient = "ebid_scripts\ebid_"+$global:BiVersionIni+"_Client_upgrade.ini"
		$global:UpgradeIniPathToCopyClient = $global:ClientMediaDrive + $global:UpgradeIniPathClient
		$global:ClientUpgradeIni = $global:UpgradeFolderPath + "\ebid_" +$global:BiVersionIni+ "_Client_upgrade.ini" 
		if(Test-Path $global:UpgradeFolderPath)
		{
			"`nUpgrade Folder is already created" >>$global:LogFile
			Remove-Item -Path "C:\ebid\upgrade" -Force -recurse >>$global:LogFile
			New-Item C:\ebid\upgrade -ItemType Directory | Out-Null
		}
		else
		{
			New-Item C:\ebid\upgrade -ItemType Directory | Out-Null
		}
		if(Test-Path $global:UpgradeIniPathToCopyClient)
		{
			if(Test-Path $global:ClientUpgradeIni)
			{
				"`nUpgrade ini is already present" >>$global:LogFile			
			}
			else
			{
				Copy-Item "$global:UpgradeIniPathToCopyClient" "$global:UpgradeFolderPath"
			}
		}
		else
		{
			"$global:UpgradeIniPathToCopyClient is missing" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			EXIT
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopyClientIni function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
	
}

# ------------------------------------------------------------------------
#  Function to Call Prerequisite Script 
# ------------------------------------------------------------------------

Function CallPrerequisitesScript()
{       
    PrintDateTime
	"`nCalling Script to execute Automated Prerequisites. Check $global:PrerequisitesScriptLog for progress" >>$global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : Install/Upgrade Prerequisites : In Progress. " -ForegroundColor Green
		if(Test-path $global:TempFile)
		{
			Remove-item $global:TempFile
		}
		$Argument = "Disable"
		$global:PrerequisitesStatus = Invoke-Expression "$global:PrerequisitesScript $Argument"
		if($global:PrerequisitesStatus -eq $True)
		{
			"`nExecution of Prerequisites is successful. Proceeding to next stage" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : Install/Upgrade Prerequisites : Successful. Proceeding to next stage.." -ForegroundColor Green
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Executing $global:PrerequisitesScript. Check $global:PrerequisitesScriptLog for more details" -ForegroundColor Red
			Exit	
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CallPrerequisitesScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Add Task in TaskScheduler 
# ------------------------------------------------------------------------

Function AddTaskInTaskScheduler()
{       
    PrintDateTime
	"`n Adding Task to  " >>$global:LogFile
	try
	{
		$schedule = new-object -com("Schedule.Service")
        $schedule.connect()
        $tasks = $schedule.getfolder("\").gettasks(0)
        foreach ($t in $tasks)
		{
            $taskName=$t.Name
            if(($taskName -eq $global:EbidAutomationTaskName))
			{
				 "Old task exist, hence deleting it." >> $global:LogFile
				schtasks /delete /tn $global:EbidAutomationTaskName /f >> $global:LogFile
            }
			elseif(($taskName -eq $global:EbidAutomationLoginTaskName))
			{
				"Old task exist, hence deleting it." >> $global:LogFile
				schtasks /delete /tn $global:EbidAutomationLoginTaskName /f >> $global:LogFile
			}
        }	
		$userInput= read-host -Prompt "`nEnter Windows Administrator Password" -AsSecureString
        $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
        $WinAdminPassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()
        if($global:Upgrade -eq $true)
        {
            schtasks /create /ru Administrator /rp $WinAdminPassword /sc ONSTART  /tn $global:EbidAutomationTaskName /tr $global:EbidAutomationTaskFile /rl highest >> $global:LogFile
        }
        elseif($global:InstallServer -eq $true)
        {
			"Creating install server task" >> $global:LogFile
            schtasks /create /ru Administrator /rp $WinAdminPassword /sc ONSTART  /tn $global:EbidAutomationTaskName /tr $global:EbidAutomationInstallServerTaskFile /rl highest >> $global:LogFile
        }
        elseif($global:InstallClient -eq $true)
        {
			"Creating install client task" >> $global:LogFile
            schtasks /create /ru Administrator /rp $WinAdminPassword /sc ONSTART  /tn $global:EbidAutomationTaskName /tr $global:EbidAutomationInstallClientTaskFile /rl highest >> $global:LogFile
        }
		
		#schtasks /create /ru system /sc ONLOGON  /tn $global:EbidAutomationLoginTaskName /tr $global:EbidAutomationLoginTaskFile /rl highest >> $global:LogFile
		$testAction = New-ScheduledTaskAction  -Execute 'powershell.exe' -Argument '-windowstyle Maximized  C:\ebid\ebid_automation\BIUpgradeProgress.ps1'
		$testTrigger = New-ScheduledTaskTrigger -AtLogon
		$testSettings = New-ScheduledTaskSettingsSet -Compatibility Win8 
		Register-ScheduledTask -TaskName $global:EbidAutomationLoginTaskName -Action $testAction -Trigger $testTrigger -Settings $testSettings >> $global:LogFile
		$schedule = new-object -com("Schedule.Service")
        $schedule.connect()
        $tasks = $schedule.getfolder("\").gettasks(0)
        foreach ($t in $tasks)
		{
            $taskName=$t.Name
            if(($taskName -eq $global:EbidAutomationTaskName))
			{
				$global:AddTaskStatus = $True
            }
			elseif(($taskName -eq $global:EbidAutomationLoginTaskName))
			{
				$global:AddLoginTaskStatus = $True
			}
        }		        
		if(($global:AddLoginTaskStatus -ne $true) -or ($global:AddTaskStatus -ne $True))
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] While adding Login task in TaskScheduler. Check $global:LogFile for more details" -ForegroundColor Red
			Exit
		}
		else
		{
			"`nExecution of Prerequisites is successful. Proceeding to next stage" >>$global:LogFile
		}		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in AddTaskInTaskScheduler function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to reboot the server 
# ------------------------------------------------------------------------

Function RebootServer()
{
	PrintDateTime
	"`nRebooting the server " >>$global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		write-host "`n$time : Rebooting Server.." -ForegroundColor Green
		write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated Prerequisites`t`t`t`t:Successful" >> $global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		shutdown -r 		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in RebootServer function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to check and initiate the BI upgrade 
# ------------------------------------------------------------------------

Function InitiateBIUpgrade()
{
	PrintDateTime
	"`nChecking the BI version" >>$global:LogFile
	try
	{
		if([bool](Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-Object {$_.DisplayName -Match $global:BIVersionName}))
		{
			"`nServer already has BI Version: $global:BIVersionName " >>$global:LogFile
			$AlreadyUpdated = Select-String -Path $global:SummaryLogFile -Pattern "BIUpgrade"
			if($AlreadyUpdated -eq $null)
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
				"`n$time : Automated BusinessObjects Upgrade`t`t`t:Completed. No Action Required" >>$global:SummaryLogFile
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
				return
			}
			else
			{
				"Summary is already printed in $global:SummaryLogFile" >>$global:LogFile
			}
		}
		else
		{
			"`nServer doesnt have BI Version: $global:BIVersionName Calling Automated Upgrade" >>$global:LogFile
			CallUpgradeScript
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in InitiateBIUpgrade function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Call Upgrade Script 
# ------------------------------------------------------------------------

Function CallUpgradeScript()
{       
    PrintDateTime
	"`nCalling Script to execute Automated Upgrade. Check $global:UpgradeScriptLog for progress " >>$global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated BusinessObjects Upgrade`t`t`t:In Progress" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		if($global:BiServerFound -eq $True)
		{
			$argumentList = "Server"
			$global:ServerMediaDrive = MountMedia($global:ServerMedia)
			$global:UpgradeStatus = Invoke-Expression "$global:UpgradeScript $argumentList"
		}
		else
		{
			$argumentList = "Client"
			$global:ServerMediaDrive = MountMedia($global:ClientMedia)
			$global:UpgradeStatus = Invoke-Expression "$global:UpgradeScript $argumentList"
		}
		if($global:UpgradeStatus -eq "Fail")
		{
			"`nExecution of $global:UpgradeScript is completed but BI Upgrade Failed. Check $global:UpgradeScriptLog for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Upgrade`t`t`t:Failed" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile 
			if((!(Test-Path -Path "HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion\Config")) -and (Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
			{
				$ebid_backup_path = ((Get-Content "c:\ebid\temp_backup.txt")+":\ebid_backup")
				"`n$time : EBID backup content is present in $ebid_backup_path directory" >>$global:LogFile
			}
			Exit
		}
		elseif($global:UpgradeStatus -eq "Success Error")
		{
			"`nExecution of $global:UpgradeScript is completed but BI Upgrade Completed with Error. Check $global:UpgradeScriptLog for more details" >>$global:LogFile			
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Upgrade`t`t`t:Completed with Errors" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			if((!(Test-Path -Path "HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion\Config")) -and (Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
			{
				$ebid_backup_path = ((Get-Content "c:\ebid\temp_backup.txt")+":\ebid_backup")
				"`n$time : EBID backup content is present in $ebid_backup_path directory" >>$global:LogFile
			}
			Exit
		}
		elseif($global:UpgradeStatus -eq "Success")
		{
			"`nExecution of $global:UpgradeScript is completed and BI Upgrade is successful. Proceeding to next stage.." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Upgrade`t`t`t:Successful" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			
			##Deleting ebid_backup folder if veritas netbackup client software is not installed on server during BIS upgrade
			if((Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
			{
				if(!(Test-Path -Path "HKLM:\SOFTWARE\Veritas\NetBackup\CurrentVersion\Config"))
				{
					$ebid_backup_path = ((Get-Content "c:\ebid\temp_backup.txt")+":\ebid_backup")
					Remove-Item -Path $ebid_backup_path -Force -recurse >>$global:LogFile
					if(Test-Path ($ebid_backup_path))
						{                
							"`n EBID backup Folder Not Deleted" >>$global:LogFile
						}
					else
						{
							"`n EBID backup Folder Deleted" >>$global:LogFile
						}
					Remove-Item -Path "c:\ebid\temp_backup.txt" -Recurse -Force
				}
				
				foreach($line in Get-Content $global:MasterScriptConfigFile) 
{
	If($line -match "product_key_required")
	{
		$line_split = "$line".split("=",2)
		$global:ProductKeyFromINI = $line_split[1].Trim()
	}	
}
				if($global:ProductKeyFromINI -eq "Yes")
				{
				$License_update = "C:\ebid\update_license\ebid_update_license.ps1"
				$ExecuteLicenseUpdate = Invoke-Expression "$License_update"
				if($ExecuteLicenseUpdate -eq "success")
				{
					$LicenseLog = "C:\ebid\update_license\ebid_update_license*.log"
					$Test_License = Test-Path $LicenseLog
					if($Test_License -eq "True"){
					$LicenseLogFile = Get-Content -Path "C:\ebid\update_license\ebid_update_license*.log"
					If($LicenseLogFile -match "Success adding License Key")
					{
					"License update is successfull." >>$global:SummaryLogFile
					"License update is successfull." >>$global:LogFile
					}
					elseif($LicenseLogFile -match "Couldn't add the license key")
					{ 
					"Invalid License Key . Exiting script for corrective action. Refer to Section , Invalid License Update in EBID, Installation and Upgrade Instructions document, to update valid license before proceeding." >>$global:SummaryLogFile
					"Invalid License Key . Exiting script for corrective action. Refer to Section , Invalid License Update in EBID, Installation and Upgrade Instructions document, to update valid license before proceeding." >>$global:LogFile
					Exit
					}
					else{
					"Invalid License Key . Exiting script for corrective action. Refer to Section , Invalid License Update in EBID, Installation and Upgrade Instructions document, to update valid license before proceeding." >>$global:SummaryLogFile
					"Invalid License Key . Exiting script for corrective action. Refer to Section , Invalid License Update in EBID, Installation and Upgrade Instructions document, to update valid license before proceeding." >>$global:LogFile
					Exit
					}
					}
				}
				elseif($ExecuteLicenseUpdate -eq "failed")
				{
					"Invalid License Key . Exiting script for corrective action. Refer to Section , Invalid License Update in EBID, Installation and Upgrade Instructions document, to update valid license before proceeding." >>$global:SummaryLogFile
					"Invalid License Key . Exiting script for corrective action. Refer to Section , Invalid License Update in EBID, Installation and Upgrade Instructions document, to update valid license before proceeding." >>$global:LogFile
					Exit
				}				
				else{
					"License update failed. Exiting script for corrective action. Refer to Section, License Update Failure in EBID, Installation and Upgrade Instructions document to update license manually before proceeding.">>$global:LogFile
					Exit
				}
				}
			}
			if($global:UpgradeStatus -eq "Success")
			{
				$Taskfound = $false
				$schedule = new-object -com("Schedule.Service")
				$schedule.connect()
				$tasks = $schedule.getfolder("\").gettasks(0)
				foreach ($t in $tasks)
				{
					$taskName=$t.Name
					if(($taskName -eq $global:EbidAutomationTaskName))
					{
						$Taskfound = $true
						"$global:EbidAutomationTaskName found before reboot " >>$global:LogFile
					}
				}
				if(!$Taskfound)
				{
					schtasks /create /ru Administrator /rp $WinAdminPassword /sc ONSTART  /tn $global:EbidAutomationTaskName /tr $global:EbidAutomationTaskFile /rl highest >> $global:LogFile
				}
			}
			if($global:UpgradeStatus -eq "Success")
			{
				$Taskfound = $false
				$schedule = new-object -com("Schedule.Service")
				$schedule.connect()
				$tasks = $schedule.getfolder("\").gettasks(0)
				foreach ($t in $tasks)
				{
					$taskName=$t.Name
					if(($taskName -eq $global:EbidAutomationLoginTaskName))
					{
						$Taskfound = $true
						"$global:EbidAutomationLoginTaskName found before reboot " >>$global:LogFile
					}
				}
				if(!$Taskfound)
				{
					"$global:EbidAutomationLoginTaskName not found before reboot and creating" >>$global:LogFile
					$testAction = New-ScheduledTaskAction  -Execute 'powershell.exe' -Argument '-windowstyle Maximized  C:\ebid\ebid_automation\BIUpgradeProgress.ps1'
					$testTrigger = New-ScheduledTaskTrigger -AtLogon
					$testSettings = New-ScheduledTaskSettingsSet -Compatibility Win8 
					Register-ScheduledTask -TaskName $global:EbidAutomationLoginTaskName -Action $testAction -Trigger $testTrigger -Settings $testSettings >> $global:LogFile
				}
				shutdown -r
				exit
			}
		}
		elseif($global:UpgradeStatus -eq "Ongoing")
		{
			"`nExecution of $global:UpgradeScript is ongoing and BI Upgrade is taking longer than usual(more than 3 hr). Hence exiting the script. " >>$global:LogFile
			"Please check upgrade log at  BI install directory/InstallData/Logs/* to get the upgrade completion status. After successful BusinessObjects upgrade, run the task EBIDAutomation in Task Scheduler to continue with rest of the automated procedures. " >>$global:LogFile
			"Refer `"EBID, Installation and Upgrade Instructions`" latest document for procedure. " >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Upgrade`t`t`t:Ongoing. `nExiting the script. Check $global:LogFile for more details. " >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
																					  																																
			write-host "`n$time : [ERROR] Check $global:LogFile for more details."
			Exit
		}
		else
		{
			"`n[ERROR] unable to get the execution status of $global:UpgradeScript." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Upgrade`t`t`t:Failed" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile			
			"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CallUpgradeScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated BusinessObjects Upgrade`t`t`t:Failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile			
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Inititate BI install 
# ------------------------------------------------------------------------

Function InitiateBIInstall()
{
	PrintDateTime
	"`nChecking the BI version" >>$global:LogFile
	try
	{
		if([bool](Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-Object {$_.DisplayName -Match $global:BIVersionName}))
		{
			"`nServer already has BI Version: $global:BIVersionName " >>$global:LogFile
			$AlreadyUpdated = Select-String -Path $global:SummaryLogFile -Pattern "BIInstall"
			if($AlreadyUpdated -eq $null)
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
				"`n$time : Automated BusinessObjects Install`t`t`t:Completed. No Action Required" >>$global:SummaryLogFile
				"`n*********************************************************************************************************" >>$global:SummaryLogFile				
			}
			else
			{
				"Summary is already printed in $global:SummaryLogFile" >>$global:LogFile
			}
		}
		else
		{
			"`nServer doesnt have BI Version: $global:BIVersionName Calling Automated Install" >>$global:LogFile
			CallInstallScript
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in InitiateBIInstall function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Call II script
# ------------------------------------------------------------------------

Function CallInstallScript()
{       
    PrintDateTime
	"`nCalling Script to execute Automated Install. Check $global:UpgradeScriptLog for progress " >>$global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated BusinessObjects Install`t`t`t:In Progress" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile        
		if($global:InstallServer -eq $True)
		{
			$argumentList = "Server"
			$global:ServerMediaDrive = MountMedia($global:ServerMedia)
			$global:InstallStatus = Invoke-Expression "$global:UpgradeScript $argumentList"
		}
		else
		{
			$argumentList = "Client"
			$global:ServerMediaDrive = MountMedia($global:ClientMedia)
			$global:InstallStatus = Invoke-Expression "$global:UpgradeScript $argumentList"
		}                
		if($global:InstallStatus -eq "Fail")
		{
			"`nExecution of $global:UpgradeScript is completed but BI Install Failed. Check $global:UpgradeScriptLog for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Install`t`t`t:Failed" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile
			Exit
		}
		elseif($global:InstallStatus -eq "Success Error")
		{
			"`nExecution of $global:UpgradeScript is completed but BI Install Completed with Error. Check $global:UpgradeScriptLog for more details" >>$global:LogFile			
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Install`t`t`t:Completed with Errors" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			Exit
		}
		elseif($global:InstallStatus -eq "Ongoing")
		{
			"`nExecution of $global:UpgradeScript is ongoing and BI Install is taking longer than usual(more than 3 hr). Hence exiting the script. " >>$global:LogFile
			"Please check BI installation log in BI install directory/InstallData/Logs/* to get the completion status. After successful BusinessObjects installation, run the task EBIDAutomation in Task Scheduler to continue with rest of the automated procedures. " >>$global:LogFile
			"Refer `"EBID, Installation and Upgrade Instructions`" latest document for procedure. " >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Install`t`t`t:Ongoing. `nExiting the script. Check $global:LogFile for more details. " >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
																					  																																
			write-host "`n$time : [ERROR] Check $global:LogFile for more details."
			Exit
		}
		elseif($global:InstallStatus -eq "Success")
		{
			"`nExecution of $global:UpgradeScript is completed and BI Install is successful. Proceeding to next stage.." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Install`t`t`t:Successful" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile    
			if($global:InstallServer -eq $True)
			{
				$Taskfound = $false
				$schedule = new-object -com("Schedule.Service")
				$schedule.connect()
				$tasks = $schedule.getfolder("\").gettasks(0)
				foreach ($t in $tasks)
				{
					$taskName=$t.Name
					if(($taskName -eq $global:EbidAutomationLoginTaskName))
					{
						$Taskfound = $true
						"$global:EbidAutomationLoginTaskName found before reboot " >>$global:LogFile
					}
				}
				if(!$Taskfound)
				{
					"$global:EbidAutomationLoginTaskName not found before reboot and creating" >>$global:LogFile
					$testAction = New-ScheduledTaskAction  -Execute 'powershell.exe' -Argument '-windowstyle Maximized  C:\ebid\ebid_automation\BIUpgradeProgress.ps1'
					$testTrigger = New-ScheduledTaskTrigger -AtLogon
					$testSettings = New-ScheduledTaskSettingsSet -Compatibility Win8 
					Register-ScheduledTask -TaskName $global:EbidAutomationLoginTaskName -Action $testAction -Trigger $testTrigger -Settings $testSettings >> $global:LogFile
				}
				RebootServer
				exit
			}
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated BusinessObjects Install`t`t`t:Failed" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n[ERROR] unable to get the execution status of $global:UpgradeScript. Check $global:UpgradeScriptLog for more details" >>$global:LogFile			
			write-host "`n$time : [ERROR] Check $global:LogFile for more details."
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CallInstallScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated BusinessObjects Install`t`t`t:Failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Check if HTTPS is enabled or not
# ------------------------------------------------------------------------

Function CheckIfHttpsEnabled()
{
	"------------------------" 
    Get-Date -format g 
	"------------------------" 
	"Checking If HTTPS is enabled.."  >>$global:LogFile
	$ErrorActionPreference = 'Continue'
	$script:https_enabled=0
	$wget_file_exists = Test-Path "C:\ebid\install_config\wget.js"
	If ($wget_file_exists -ne "True")
	{			
		"`"C:\ebid\install_config\wget.js`" file missing!" >>$global:LogFile 
		return $false
	} 
	Else 
	{
        $Computername = hostname
		cscript C:\ebid\install_config\wget.js https://$Computername`:8443/BOE/CMC >>$global:LogFile 2>&1 
		If ( $? -eq "True" ) 
		{
			$script:https_enabled=1 
			"HTTPS is enabled in the server" >>$global:LogFile
            return "HTTPS is enabled in the server"
		}
		Else 
		{	
			$wget_response = invoke-expression "& cscript.exe C:\ebid\install_config\wget.js https://$env:computername`:8443/BOE/CMC 2>&1" -ErrorAction silentlycontinue -ErrorVariable error_msg			
			If ($error_msg -like '*The certificate authority is invalid or incorrect*' -or $wget_response -like '*The certificate authority is invalid or incorrect*') 
			{
				$script:https_enabled=1
				"HTTPS is enabled on server but not installed in browser"  >>$global:LogFile
                return "HTTPS is enabled on server but not installed in browser"
			}
			Else 
			{
				"HTTPS is not enabled in the server" >>$global:LogFile
                return "HTTPS is not enabled in the server"
			}			
		}
	}	
}

# ------------------------------------------------------------------------
#  Function to Backup original server.xml and web.xml files
# ------------------------------------------------------------------------

function BackupServerWeb()
{
	try
	{
		$bi_install_dir=(Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir -ErrorAction SilentlyContinue).InstallDir
		PrintDateTime

		# Creating C:\ebid\SSL\backup\orig\ directory
		if (Test-Path -Path "C:\ebid\SSL\backup\orig\")
		{
			"C:\ebid\SSL\backup\orig\ directory found" >>$global:LogFile
		}
		else
		{
			"Creating C:\ebid\SSL\backup\orig\ directory" >>$global:LogFile
			New-Item "C:\ebid\SSL\backup\orig\" -ItemType "directory"  -Force

			if (Test-Path -Path C:\ebid\SSL\backup\orig\)
			{
				"C:\ebid\SSL\backup\orig\ directory created successfully" >>$global:LogFile
			}
			else
			{
				New-Item "C:\ebid\SSL\backup\orig\" -ItemType "directory"  -Force
				"C:\ebid\SSL\backup\orig\ directory created successfully" >>$global:LogFile
			}
		}

		# Backup tomcat\conf\server.xml
		if (Test-Path -Path $bi_install_dir"\tomcat\conf\server.xml")
		{
			Copy-Item $bi_install_dir"\tomcat\conf\server.xml" -Destination "C:\ebid\SSL\backup\orig\"

			if (Test-Path -Path "C:\ebid\SSL\backup\orig\server.xml")
			{
				"server.xml file copied successfully" >>$global:LogFile
			}
			else
			{
				"server.xml file not copied. Trying again" >>$global:LogFile
				Copy-Item $bi_install_dir"\tomcat\conf\server.xml" -Destination "C:\ebid\SSL\backup\orig\" -Force
				"server.xml file copied successfully" >>$global:LogFile
			}
		}
		else
		{
			"server.xml file not found" >>$global:LogFile
		}

		# Backup tomcat\conf\web.xml
		if (Test-Path -Path $bi_install_dir"\tomcat\conf\web.xml")
		{
			Copy-Item $bi_install_dir"\tomcat\conf\web.xml" -Destination "C:\ebid\SSL\backup\orig\"

			if (Test-Path -Path "C:\ebid\SSL\backup\orig\web.xml")
			{
				"web.xml file copied successfully" >>$global:LogFile
			}
			else
			{
				"web.xml file not copied. Trying again" >>$global:LogFile
				Copy-Item $bi_install_dir"\tomcat\conf\web.xml" -Destination "C:\ebid\SSL\backup\orig\" -Force
				"web.xml file copied successfully" >>$global:LogFile
			}
		}
		else
		{
			"web.xml file not found" >>$global:LogFile
		}
	}
	catch
    {
		"`nException in BackupServerWeb function"  >>$global:LogFile
		$_ >>$global:LogFile
    }
}

# ------------------------------------------------------------------------
#  Function to Generate tomcatssl.bin file
# ------------------------------------------------------------------------

function GenerateBinfile()
{
    try
    {
        PrintDateTime
        "Generating tomcatssl.bin file in C:\ebid\SSL\CA\cert\ folder" >>$global:LogFile
		$AppBaseValue = $False
        $BiInstallDir = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir).InstallDir
        $KeyToolPath = $BiInstallDir+'SAP BusinessObjects Enterprise XI 4.0\win64_x64\sapjvm\bin\keytool.exe'
		$WebappPath = $BiInstallDir+'tomcat\webapps'
        $KeyToolPath >>$global:LogFile
        foreach($line in Get-Content "C:\ebid\TempPwd.ini") 
        { 
         	if($line -match "SSL_KeyPassword=")
        	{            
        	    $LineSplit = "$line".split("=",2)
        	    $Password = $LineSplit[1].Trim()            
        	}                       	            
        }
        $ComputerName = hostname
        if(Test-Path -Path "C:\ebid\SSL\CA\cert")
        {
             Write-Host "CA cert folder is already present"
        }
        else
        {
             Write-Host "CA cert folder is not present and creating it"
             New-Item C:\ebid\SSL\CA\cert -ItemType Directory | Out-Null
        }
        $CertPath = "C:\ebid\SSL\CA\cert\tomcatssl.bin"
        $P12Path = "C:\ebid\SSL\CA\tomcatssl.p12"
        
        Copy-Item -Path "C:\Certificates\tomcatssl.p12" -Destination "C:\ebid\SSL\CA\"
        Start-Sleep -Seconds 5
		if(Test-Path -Path $CertPath)
		{
			"Tomcatssl.bin file is already present in $CertPath and checking app base value in server.xml " >>$global:LogFile			
			$TomcatServerXMLPath = 'C:\ebid\SSL\CA\xml\server.xml'
			if(Test-Path -Path $TomcatServerXMLPath)
			{
				$xml = [xml](Get-Content $TomcatServerXMLPath)
				$con = $xml.Server.Service.Engine.Host
				$GetAppBaseValue = $con.GetAttribute('appBase')
				"$GetAppBaseValue Appbase Value" >>$global:LogFile			
				if($GetAppBaseValue -eq $WebappPath)
				{
					"Appbase already updated with BI install directory" >>$global:LogFile
					$AppBaseValue = $True
				} 
				else
				{
					"Appbase not updated with BI install directory" >>$global:LogFile
					Remove-Item -Path "C:\ebid\SSL\CA\cert\tomcatssl.bin" -Force
					Start-Sleep -Seconds 5
					& $KeyToolPath -importkeystore -destkeystore $CertPath -srckeystore $P12Path -srcstoretype PKCS12 -srcalias "$ComputerName" -destalias "bosap" -srcstorepass $Password -deststorepass $Password	
				}
			}
			else
			{
				"server.xml doesn't available in C:\ebid\SSL\CA\xml path." >>$global:LogFile				
				Remove-Item -Path "C:\ebid\SSL\CA\cert\tomcatssl.bin" -Force
				Start-Sleep -Seconds 5
				& $KeyToolPath -importkeystore -destkeystore $CertPath -srckeystore $P12Path -srcstoretype PKCS12 -srcalias "$ComputerName" -destalias "bosap" -srcstorepass $Password -deststorepass $Password	
			}
		}
		else		
		{
			& $KeyToolPath -importkeystore -destkeystore $CertPath -srckeystore $P12Path -srcstoretype PKCS12 -srcalias "$ComputerName" -destalias "bosap" -srcstorepass $Password -deststorepass $Password		
		}
		        
		if(Test-Path -Path $CertPath)
		{
			if($AppBaseValue)
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
				"`n$time : Automated HTTPS Configuration`t`t`t:Successful" >>$global:SummaryLogFile
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
			}
			else
			{
				UpdateServerXml $Password
			}			
		}
		else
		{
			"Unable to create tomcatssl.bin file for Configuring HTTPS. Please Configure HTTPS manually and Open task scheduler then right click EBIDAutomation task from middle pane and Click Run." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile
			exit
		}        
    }
    catch
    {
        $_ >>$global:LogFile
		"`nException in GenerateBinfile function"  >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
    }
}

# ------------------------------------------------------------------------
#  Function to Update keystore Password Server.xml file
# ------------------------------------------------------------------------

function UpdateServerXml($Password)
{
    try
    {
        PrintDateTime
        "Updating server.xml with keystorpassword" >>$global:LogFile
        $serverXmlPath = "C:\ebid\SSL\CA\xml\server.xml"
        $xml = [xml](Get-Content $serverXmlPath)
        foreach ($con in $xml.Server.Service.Connector)
        {
            if($con.HasAttribute('keystorePass'))
            {            
                $newContent = (Get-Content -path $serverXmlPath -Raw) -replace "keystorePass=`"default`"","keystorePass=`"$Password`""
                Set-Content -path $serverXmlPath -Value $newContent
				"Keystore Password updated successfully" >>$global:LogFile		 
            }
        }
        UpdateappBase
    }
    catch
    {
        $_ >>$global:LogFile
		"`nException in UpdateServerXml function"  >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
    }
}

# ------------------------------------------------------------------------
#  Function to UpdateAppbase in server.xml
# ------------------------------------------------------------------------

function UpdateappBase()
{
    try
    {
        PrintDateTime
        "Updating server.xml with appbase" >>$global:LogFile
        $TomcatServerXML = "C:\ebid\SSL\CA\xml\server.xml"
        $BiInstallDir = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir).InstallDir
        $WebappsPath = $BiInstallDir+'tomcat\webapps'
        $xml = [xml](Get-Content $TomcatServerXML)
        $con = $xml.Server.Service.Engine.Host
		Start-Sleep  -seconds 15
        if($con.HasAttribute('appBase'))
        {
            $con.SetAttribute("appBase","$WebappsPath")
            $xml.Save($TomcatServerXML)
        }
        CopyXmlFiles
    }
    catch
    {
        $_ >>$global:LogFile
		"`nException in UpdateappBase function"  >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated Https Configuration`t`t`t:failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
    }
}

# ------------------------------------------------------------------------
#  Function to Copy XML files to tomcat\conf folder
# ------------------------------------------------------------------------

function CopyXmlFiles()
{
    try
    {
        PrintDateTime
        "copying server.xml and web.xml to tomcat\conf folder" >>$global:LogFile
        $BiInstallDir = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir).InstallDir
        $TomcatConf = $BiInstallDir+'tomcat\conf'
        Copy-Item -Path "C:\ebid\SSL\CA\xml\server.xml" -Destination $TomcatConf -Force
        Copy-Item -Path "C:\ebid\SSL\xml\web.xml" -Destination $TomcatConf -Force
        "`nExecution of $global:SSLScript is completed." >>$global:LogFile
    	$time = get-date -Format "yyyy MM dd HH:mm:ss"
		RestartTomcat		
    }
    catch
    {
        $_ >>$global:LogFile
		"`nException in CopyXmlFiles function"  >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
    }
}

function RestartTomcat()
{  
	try
	{
		$service_name="BOEXI40Tomcat"
		"Restarting Tomcat"  >>$global:LogFile	
		$curr_Service = get-service -Name $service_name
		if($curr_Service.Status -ne "Stopped")
		{
			net stop $service_name
		}		
		$Time = 0
		$curr_Service = get-service -Name $service_name
		while(($Time -lt 120) -and ($curr_Service.Status -ne "Stopped"))
		{
			$Time = $Time + 1
			Start-Sleep  -seconds 5
			$curr_Service = get-service -Name $service_name	
		}
		$curr_Service = get-service -Name $service_name
		if($curr_Service.Status -ne "Stopped")
		{	
			"Tomcat service is not stopped. Please restart the service manually" >>$global:LogFile
		}
		elseif($curr_Service.Status -eq "Stopped")
		{
			"Tomcat service is stopped and starting Tomcat" >>$global:LogFile
			if($global:DeleteLocalhost -eq $true)				
			{
				$x=100
				$bi_install_dir=(Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir -ErrorAction SilentlyContinue).InstallDir
				Get-ChildItem ($bi_install_dir+"\tomcat\work\Catalina\localhost\") -Directory -Recurse| Rename-Item -NewName  { $_.name -replace $_.Name,($x++) }          
				Write-Host "Deleting the localhost folder"
				Remove-Item -Path ($bi_install_dir+"\tomcat\work\Catalina\localhost") -Recurse -Force -Confirm:$false
				if(Test-Path ($bi_install_dir+"\tomcat\work\Catalina\localhost"))
				{                
					"Tomcat Cache Folder Not Deleted" >>$global:LogFile
				}
				else
				{
					"Tomcat Cache Folder Deleted" >>$global:LogFile
				}
			}
			Start-Sleep  -seconds 5
			net start $service_name
			$Time = 0
			while(($Time -lt 120) -and ($curr_Service.Status -ne "Running"))
			{
				$Time = $Time + 1
				Start-Sleep  -seconds 5
				$curr_Service = get-service -Name $service_name					
			}
			if($curr_Service.Status -ne "Running")
			{		
				"Tomcat service is not started. Please start the service manually" >>$global:LogFile
				$Script:SSLErrorCheck += 1
			}
			elseif($curr_Service.Status -eq "Running")
			{
				"Tomcat service started successfully"  >>$global:LogFile
				if($global:DeleteLocalhost -eq $false)				
				{
					$time = get-date -Format "yyyy MM dd HH:mm:ss"
					"`n*********************************************************************************************************" >>$global:SummaryLogFile
					"`n$time : Automated HTTPS Configuration`t`t`t:Successful" >>$global:SummaryLogFile
					"`n*********************************************************************************************************" >>$global:SummaryLogFile
				}
			}
		}        
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in RestartTomcat function"  >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
	}
}

# ------------------------------------------------------------------------
#  Function to Configure HTTPS
# ------------------------------------------------------------------------

function ConfigureHttps()
{
    PrintDateTime
    "`nCalling Script to execute configure https." >>$global:LogFile
    try
	{
        $destination_Directory = "C:\ebid"
        $global:EBIDMediaDrive = MountMedia($global:EBIDMedia)
		
		Backup_LegalNoticeFiles
		Backup_LegalNotice_AdminUI
        $file_To_Be_Copied = ($global:EBIDMediaDrive + $global:InstallConfigPath)
        copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
		Restore_LegalNoticeFiles
		
        $CheckHttps = CheckIfHttpsEnabled
        $CheckHttps >>$global:LogFile
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
        if($CheckHttps -ne "HTTPS is enabled in the server")
        {            
		    "`n*********************************************************************************************************" >>$global:SummaryLogFile
		    "`n$time : Automated HTTPS Configuration `t`t`t:In Progress" >>$global:SummaryLogFile
		    "`n*********************************************************************************************************" >>$global:SummaryLogFile 
            if(Test-Path -Path "C:\ebid\TempPwd.ini")
            {
                $file_To_Be_Copied = ($global:EBIDMediaDrive + $global:SSLPath)
				if(Test-Path -Path "C:\ebid\SSL")				
				{
					"SSL folder already copied" >>$global:LogFile
				}
				else
				{
					copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory           
				}
                Get-ChildItem -Path "C:\ebid\SSL\*" -Recurse -File | % { $_.IsReadOnly=$False }
                if (test-path -Path ($destination_Directory+"\"+$global:SSLPath))
		        {
		        	"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		        }
		        else
		        {
		        	"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		        	$time = get-date -Format "yyyy MM dd HH:mm:ss"
					"`n[ERROR] unable to find C:\ebid\TempPwd.ini for fetching required inputs and exiting from script" >>$global:LogFile
					"`n*********************************************************************************************************" >>$global:SummaryLogFile
					"`n$time : Automated HTTPS Configuration`t`t`t:failed" >>$global:SummaryLogFile
					"`n*********************************************************************************************************" >>$global:SummaryLogFile
		        	write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
					"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile
		        	Exit
		        }
                if(Test-Path -Path "C:\Certificates\tomcatssl.p12")
                {
                    "tomcatssl.p12 is present in C:\Certificates folder and configuring CA certificates"  >>$global:LogFile
                    BackupServerWeb
					GenerateBinfile   
                }
                else
                {
                    "tomcatssl.p12 is not present in C:\Certificates folder and configuring self-signed certificates" >>$global:LogFile
                    $argumentList = "EnableDefaultSSL"			
		    	    $global:SSLStatus = Invoke-Expression "$global:SSLScript $argumentList"	            
                    if($global:SSLStatus -eq $false)
                    {
                        "`nExecution of $global:SSLScript is failed. Please execute Manual procedure to configure Https" >>$global:LogFile
    	    	    	$time = get-date -Format "yyyy MM dd HH:mm:ss"
		    	        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		    	        "`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		    	        "`n*********************************************************************************************************" >>$global:SummaryLogFile
						"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile
                    }
                    elseif($global:SSLStatus -eq $true)
                    {
                        "`nExecution of $global:SSLScript is completed." >>$global:LogFile
    	    	    	$time = get-date -Format "yyyy MM dd HH:mm:ss"
		    	        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		    	        "`n$time : Automated HTTPS Configuration`t`t`t:Successful" >>$global:SummaryLogFile
		    	        "`n*********************************************************************************************************" >>$global:SummaryLogFile
                    }
                    else
                    {
                        "`n[ERROR] unable to get the execution status of $global:SSLScript." >>$global:LogFile
                        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		    	        "`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		    	        "`n*********************************************************************************************************" >>$global:SummaryLogFile
						"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile
		    	        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		    	        write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
                    }
                }
            }
            else
            {                
                "`n[ERROR] unable to find C:\ebid\TempPwd.ini for fetching required inputs and exiting from script" >>$global:LogFile
                "`n*********************************************************************************************************" >>$global:SummaryLogFile
		        "`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		        "`n*********************************************************************************************************" >>$global:SummaryLogFile
				"`n$time : [ERROR] Check $global:LogFile for more details." >>$global:SummaryLogFile
                exit
            }
        }
        else
        {
            "`n*********************************************************************************************************" >>$global:SummaryLogFile
		    "`n$time : Automated HTTPS Configuration`t`t`t:Completed. No action required" >>$global:SummaryLogFile
		    "`n*********************************************************************************************************" >>$global:SummaryLogFile 
        }           
    }
    catch
	{
		$_ >>$global:LogFile
		"`nException in ConfigureHttps function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"		
        "`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated HTTPS Configuration`t`t`t:Failed" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to housekeeping Object ID
# ------------------------------------------------------------------------

function UpdateHouseKeepingObjId()
{
    if(Test-Path -Path $global:HouseKeepingini)
    {
        $Installini = (Get-ChildItem C:\ebid\install -Filter *.ini -Recurse | % { $_.FullName })
        foreach($line in Get-Content $Installini)
        {
            if($line -match "cmspassword=")
            {
                $line_split = "$line".split("=",2)
	    	    $Cmspassword = $line_split[1].Trim()                
            }
        }
        $HostName = hostname
        #$Computername = $HostName+":6400"
        $objSessionMgr = New-Object -com ("CrystalEnterprise.SessionMgr")            
        $objEnterpriseSession = $objSessionMgr.Logon("Administrator",$Cmspassword,$HostName,"Enterprise") 
        $objInfoStore = $objEnterpriseSession.Service("","InfoStore")            
        $objInfoObjects = $objInfoStore.Query("select SI_ID from ci_systemobjects where si_name='Administrator' and SI_KIND='user'") 
        $biAdmID = $objInfoObjects | Select-Object -ExpandProperty ID
        $regex4 = [regex] '(?m)^bi_adm_obj_id=$'
        (Get-Content $global:HouseKeepingini) -replace $regex4, "bi_adm_obj_id=$biAdmID" | Set-Content $global:HouseKeepingini
    }
}

# ------------------------------------------------------------------------
#  Function to check and initiate Automated Post Installation
# ------------------------------------------------------------------------

Function InitiatePostInstallation()
{
	PrintDateTime
	"`nChecking if Post installation is already executed" >>$global:LogFile
	try
	{
		$AlreadyUpdated = Select-String -Path $global:SummaryLogFile -Pattern "AutomatedPostInstallation"
		if( $AlreadyUpdated -eq $null)
		{
			"`nPost Installation is not executed in the Server. Calling Script to execute Post Installation" >>$global:LogFile
			$global:EBIDMediaDrive = MountMedia($global:EBIDMedia)
			$global:WindowsMediaDrive = MountMedia($global:WindowsMedia)
			if($global:BiServerFound -eq $true)
			{
				CopyNecessaryFilesPostInstall
			}
			else
			{	
				if(($global:ClientStatus -eq "Yes") -OR ($global:ClientStatus -eq "Y"))
				{
					CopyNecessaryFilesPostInstallClient
				}
				else
				{
					CopylatestInstallConfig
				}	
			}
			
			CallPostInstallationScript
		}
		else
		{
			"`nPost Installation is already executed in the Server" >>$global:LogFile
			return
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in InitiatePostInstallation function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Copy Latest Audit Files
# ------------------------------------------------------------------------


Function CopylatestAudit()
{		
	PrintDateTime
	try
	{   
		$destination_Directory = "C:\"
		$global:WindowsMediaDrive = MountMedia($global:WindowsMedia)
		$file_To_Be_Copied = ($global:WindowsMediaDrive + $global:AuditPath)
		if (test-path -Path ($destination_Directory+"\"+$global:AuditPath))
		{
			foreach($line in Get-Content $global:AuditConfigFile) 
			{        
				if($line -match "directorysize =")
				{            
					$LineSplit = "$line".split("=",2)
					$global:prevAuditValue = $LineSplit[1].Trim()
					$HasValue = NullCheck $global:prevAuditValue "Audit directorysize"
					If($HasValue -eq $False)
					{
						"Audit directorysize is not available" >>$global:LogFile
					}
					else
					{						
						"Audit directorysize is available" >>$global:LogFile
					}
				}
			}
		}		
		copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
		Get-ChildItem -Path "C:\Audit\*" -Recurse -File | % { $_.IsReadOnly=$False }
		if (test-path -Path ($destination_Directory+"\"+$global:AuditPath))
		{
			"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			Get-ChildItem "C:\Audit" -Recurse | foreach {$_.Attributes = 'Normal'}
		}
		else
		{
			"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}
		if($global:prevAuditValue)
		{
			(Get-Content $global:AuditConfigFile) -replace '^directorysize =.+$', "directorysize = $global:prevAuditValue" | Set-Content $global:AuditConfigFile
		}
		else
		{
			"Value for Audit directory size is not available. Hence it is set to default" >>$global:LogFile
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopylatestAudit function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}



# ------------------------------------------------------------------------
#  Function to copy files necessary for Automated Post Installation Script Execution
# ------------------------------------------------------------------------

Function CopyNecessaryFilesPostInstall()
{
	PrintDateTime
	"`n Copying Files" >>$global:LogFile
	$CountCopied = 0
	try
	{
		$destination_Directory = "C:\ebid"
		CopylatestInstallConfig
		CopylatestAudit
		$file_To_Be_Copied = ($global:EBIDMediaDrive + $global:DataCollectorPath)
		copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
		Get-ChildItem -Path "C:\ebid\data_Collector\*" -Recurse -File | % { $_.IsReadOnly=$False }
		if (test-path -Path ($destination_Directory+"\"+$global:DataCollectorPath))
		{
			"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		}
		else
		{
			"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}		
		
		$destination_Directory = "C:\"
		$file_To_Be_Copied = ($global:WindowsMediaDrive + $global:CertExpiryPath)
		copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
		Get-ChildItem -Path "C:\Certificate-expiry\*" -Recurse -File | % { $_.IsReadOnly=$False }
		if (test-path -Path ($destination_Directory+"\"+$global:CertExpiryPath))
		{
			"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		}
		else
		{
			"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopyNecessaryFilesPostInstall function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to copy files necessary for Automated Post Installation Script Execution for Client
# ------------------------------------------------------------------------

Function CopyNecessaryFilesPostInstallClient()
{
	PrintDateTime
	"`n Copying Files" >>$global:LogFile
	$CountCopied = 0
	try
	{
		
		CopylatestInstallConfig
		CopylatestAudit
		$destination_Directory = "C:\OCS-without-Citrix"
		if (!(Test-Path $destination_Directory))
		{
			"$destination_Directory is not present and creating it.." >> $global:LogFile
			New-Item -ItemType directory "C:\OCS-without-Citrix" -ErrorAction stop | Out-Null
		}
		else
		{
			"$destination_Directory is already present." >> $global:LogFile
		}		
		$file_To_Be_Copied = ($global:EBIDMediaDrive + $global:DataCollectorStandalonePath)
		copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
		Get-ChildItem -Path "C:\OCS-without-Citrix\data_collector_standalone\*" -Recurse -File | % { $_.IsReadOnly=$False }
		if (test-path -Path ($destination_Directory+"\"+$global:DataCollectorStandalonePath))
		{
			"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		}
		else
		{
			"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}		
		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CopyNecessaryFilesPostInstallClient function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Call Automated Post Installation Script 
# ------------------------------------------------------------------------

Function CallPostInstallationScript()
{       
    PrintDateTime
	"`nCalling Script to execte Automated Post Installation. Check $global:PostInstallScriptLog for progress. " >>$global:LogFile
	try
	{
		$argumentList = "Autosetconf"
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated Post Installation`t`t`t:In Progress" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		$global:AutomatedPostInstallStatus = Invoke-Expression "$global:PostInstallScript $argumentList"
		if($global:AutomatedPostInstallStatus -eq "Failed")
		{
			"`nExecution of $global:PostInstallScript is completed but Post Installation Failed. Check $global:PostInstallScriptLog for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Post Installation`t`t`t:Failed" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
		}
		elseif($global:AutomatedPostInstallStatus -eq "Success Error")
		{
			"`nExecution of $global:PostInstallScript is completed but Post Installation Completed with Error. Check $global:PostInstallScriptLog for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Post Installation`t`t`t:Completed with Errors" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
		}
		elseif($global:AutomatedPostInstallStatus -eq "Success")
		{
			"`nExecution of $global:PostInstallScript is completed and Post Installation is successful. Proceeding to next stage.." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Post Installation`t`t`t:Successful" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
		}
		else
		{
			"`n[ERROR] unable to get the execution status of $global:PostInstallScript." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"			
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Post Installation`t`t`t:Failed" >>$global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
			Exit
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CallPostInstallationScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to copy folders 
# ------------------------------------------------------------------------ 

Function copy_Folder($source_directory, $destination_Directory)
{
    try
    {
	    copy-item -path $source_directory -destination $destination_Directory -Recurse -Force
	    return 
    }
    catch
	{
		$_ >>$global:LogFile
		"`nException in copy_Folder function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to check and initiate the BI upgrade 
# ------------------------------------------------------------------------

Function InitiateNWClientUpgrade()
{
	PrintDateTime
    
	"`nChecking the Network Client version" >>$global:LogFile
	try
	{
		if([bool]((Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*) | Where-Object {$_.DisplayName -match $global:NWClientVersionName}))
		{
			$AlreadyUpdated = Select-String -Path $global:SummaryLogFile -Pattern "NetworkClientUpgrade"
			if($AlreadyUpdated -eq $null)
			{
				$time = get-date -Format "yyyy MM dd HH:mm:ss"
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
				"`n$time : Automated Network Client Install/Upgrade`t`t`t:Completed. No Action Required" >>$global:SummaryLogFile
				"`n*********************************************************************************************************" >>$global:SummaryLogFile
				Start-Process -FilePath "cmd.exe"  -ArgumentList '/c "regsvr32 /S C:\Sybase\IQ-16_1\Bin32\dbodbc17.dll"' -ErrorAction SilentlyContinue
			    Start-Process -FilePath "cmd.exe"  -ArgumentList '/c "regsvr32 /S C:\Sybase\IQ-16_1\Bin64\dbodbc17.dll"' -ErrorAction SilentlyContinue
                return
			}
			else
			{
				"Summary is already printed in $global:SummaryLogFile" >>$global:LogFile
			}
			"`nServer already has Network Client Version: $global:NWClientVersionName " >>$global:LogFile
			return
		}
		else
		{
			"`nServer doesn't has Network Client Version: $global:NWClientVersionName Calling script to Execute Network Client Upgrade" >>$global:LogFile
			$global:ServerMediaDrive = MountMedia($global:SAPIQNWClientMedia)
			CallNWClientUpgradeScript
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in InitiateNWClientUpgrade function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Call NW Client Upgrade Script 
# ------------------------------------------------------------------------

Function CallNWClientUpgradeScript()
{       
    PrintDateTime
	"`nCalling Script to execte Automated Network Client Install/Upgrade. Check $global:NWClientUpgradeScriptLog for progress. " >>$global:LogFile
	try
	{
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		#"`n*********************************************************************************************************" >>$global:SummaryLogFile
		#"`n$time : Automated Network Client Install/Upgrade`t`t`t:In Progress" >>$global:SummaryLogFile
		#"`n*********************************************************************************************************" >>$global:SummaryLogFile
		$global:NWClientUpgradeStatus = Invoke-Expression "$global:NWClientUpgradeScript"
		if($global:NWClientUpgradeStatus -eq "Fail")
		{
			"`nExecution of $global:NWClientUpgradeScript is completed but Network Client Upgrade Failed. Check $global:NWClientUpgradeScriptLog for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Network Client Install/Upgrade`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
		}
		elseif($global:NWClientUpgradeStatus -eq "Success Error")
		{
			"`nExecution of $global:NWClientUpgradeScript is completed but Network Client Upgrade Completed with Error. Check $global:NWClientUpgradeScriptLog for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Network Client Install/Upgrade`t`t`t:Completed with error" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile			
		}
		elseif($global:NWClientUpgradeStatus -eq "Success")
		{
			"`nExecution of $global:NWClientUpgradeScript is completed and Network Client Upgrade is successful." >>$global:LogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n$time : Automated Network Client Install/Upgrade`t`t`t:Successful" >> $global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			Start-Process -FilePath "cmd.exe"  -ArgumentList '/c "regsvr32 /S C:\Sybase\IQ-16_1\Bin32\dbodbc17.dll"' -ErrorAction SilentlyContinue
			Start-Process -FilePath "cmd.exe"  -ArgumentList '/c "regsvr32 /S C:\Sybase\IQ-16_1\Bin64\dbodbc17.dll"' -ErrorAction SilentlyContinue
			"Command executed for SAP IQ Network SP05 ">>$global:LogFile
			"----------------------------------------------- " >>$global:LogFile  
			"Summary of Automated Upgrade : " >> $global:LogFile
			Get-Content $global:SummaryLogFile >> $global:LogFile
			"----------------------------------------------- " >>$global:LogFile  
		}
		else
		{
			"`n[ERROR] unable to get the execution status of $global:NWClientUpgradeScript." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Network Client Install/Upgrade`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red			
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CallNWClientUpgradeScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated Network Client Install/Upgrade`t`t`t:Failed" >> $global:SummaryLogFile	
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red		
	}
}


#function to check eniq ini file
function CheckEniqIni()
{
	$WindowsDriveLetter = MountMedia($global:EBIDMedia)	
	$destination_Directory = "C:\ebid\ebid_automation\"
	$file_To_Be_Copied = ($WindowsDriveLetter + $global:Eniq_Ini_Path)	
	copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
	if (test-path -Path "C:\ebid\ebid_automation\eniq.ini")
	{
		"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		Set-ItemProperty -Path $destination_Directory\ebid_automation.ini -Name IsReadOnly -Value $false
	}
	else
	{
		"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}


#function to check universe report promotion folder is present
function CheckUniveseReportfolder()
{
	$WindowsDriveLetter = MountMedia($global:EBIDMedia)	
	$destination_Directory = "C:\ebid\"
	$file_To_Be_Copied = ($WindowsDriveLetter + $global:Universe_Report_Path)	
	copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
	if (test-path -Path "C:\ebid\universe_report_promotion")
	{
		"`nCopied $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
	}
	else
	{
		"`nCouldn't copy $file_To_Be_Copied to $destination_Directory" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}


#calling script for univese report promotion
Function InitiateUniversePromotion()
{

# PrintDateTime
	"`nCalling Script to Promote universe and report. Check C:\ebid\universe_report_promotion\Universe_Report_Promotion_log-yyyy-MM-dd-HH:mm:ss " >>$global:LogFile
	try
	{   
	    CheckUniveseReportfolder
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated Universe Report Promotion`t`t`t:In Progress" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		$global:UniverseReportPromotionStatus = Invoke-Expression "$global:UniverseReportPromotionScript"
		
		
		
		
		
		
		if($global:Downloadcount -gt $global:Statuscount)
		{
			"`nUniverse Report Promotion is failed. Check C:\ebid\universe_report_promotion\Universe_Report_Promotion_log-yyyy-MM-dd-HH:mm:ss for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Universe report promotion`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile fo more details." -ForegroundColor Red	
		}
		
		elseif($global:Statuscount -ge $global:Downloadcount -and $global:Downloadcount -ne 0)
		{
			"`nUniverse Report Promotion is completed. Check C:\ebid\universe_report_promotion\Universe_Report_Promotion_log-yyyy-MM-dd-HH:mm:ss for more details." >>$global:LogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n$time : Automated Universe Report Promotion`t`t`t:Successful" >> $global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
		
			
		}
		
		elseif($global:Availablerep -eq 1 -or $global:Availableuniv -eq 1)
		{
			"`nUniverse Report Promotion is failed. Check C:\ebid\universe_report_promotion\Universe_Report_Promotion_log-yyyy-MM-dd-HH:mm:ss for more details." >>$global:LogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n$time : Automated Universe report promotion`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile fo more details." -ForegroundColor Red	
		
			
		}
		elseif($global:CmcLogin -gt 1 -or $global:EniqLogin -ge 3)
		{
			"`nUniverse Report Promotion is failed. Check C:\ebid\universe_report_promotion\Universe_Report_Promotion_log-yyyy-MM-dd-HH:mm:ss for more details." >>$global:LogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n$time : Automated Universe report promotion`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile fo more details." -ForegroundColor Red			
		}
		
		elseif($global:Downloadcount -eq 0)
		{
			"`nUniverse Report Promotion is failed. Check C:\ebid\universe_report_promotion\Universe_Report_Promotion_log-yyyy-MM-dd-HH:mm:ss for more details." >>$global:LogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n$time : Automated Universe report promotion`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile fo more details." -ForegroundColor Red			
		}
			
		
		else
		{
			"`n[ERROR] unable to get the execution status of $global:UniverseReportPromotionScript." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Universe report promotion`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile fo more details." -ForegroundColor Red			
		}
	}
	catch
	{
		"`nExecution of $global:UniverseReportPromotionScript is completed." >>$global:LogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n$time : Automated Universe report promotion`t`t`t:Successful" >> $global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
		
			"Summary of Automated Upgrade : " >> $global:LogFile
			Get-Content $global:SummaryLogFile >> $global:LogFile
			"----------------------------------------------- " >>$global:LogFile  	
	}
}





# ------------------------------------------------------------------------
#  Function to Unmount Media
# ------------------------------------------------------------------------

Function UNMountMedia($Media)
{
	try
	{
		PrintDateTime
		"unmounting Media $Media" >>$global:LogFile
		if(Test-Path $Media)
		{
			if((Get-DiskImage -ImagePath $Media).Attached)
			{
				Dismount-DiskImage -ImagePath $Media
				"unmounted Media $Media" >>$global:LogFile
			}
			else
			{	
				"Media : $Media is not mounted" >>$global:LogFile
			}
		}
		else
		{
			"$Media is missing" >>$global:LogFile
		}
	}
    catch
	{
		$_ >>$global:LogFile
		"`nException in UNMountMedia function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Call Prerequisite Script to revert the changes
# ------------------------------------------------------------------------

Function CallPrerequisitesRevertScript()
{       
    PrintDateTime
	"`nCalling Script to execute Automated Prerequisites Revert. Check $global:PrerequisitesScriptLog for progress" >>$global:LogFile
	try
	{
		$Argument = "Enable"
		$global:PrerequisitesRevertStatus = Invoke-Expression "$global:PrerequisitesScript $Argument"
		if($global:PrerequisitesRevertStatus -eq $True)
		{
			"`nExecution of Prerequisites Revert is successful." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : Execution of Prerequisites Revert is successful. Proceeding to next stage.."	-ForegroundColor Green	
			$time = get-date -Format "yyyy MM dd HH:mm:ss"			
			write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Executing Revert $global:PrerequisitesScript. Check $global:PrerequisitesScriptLog for more details" -ForegroundColor Red
			Exit	
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CallPrerequisitesRevertScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to check windows hardening folder is present or not
# ------------------------------------------------------------------------

function CheckWindowsHardeningfolder()
{
	$WindowsDriveLetter = MountMedia($global:WindowsMedia)
	$destination_Directory = "C:\Windows_Hardening\"
	
	try
	{
		if (Test-Path -Path $destination_Directory)
		{
			"$destination_Directory directory found" >>$global:LogFile
		}
		else
		{
			"Creating $destination_Directory directory" >>$global:LogFile
			New-Item $destination_Directory -ItemType "directory" -Force
		}
		
		$LegalNotice_To_Be_Copied = ($WindowsDriveLetter + $global:WindowsHardeningPath + "\LegalNotice.ini")
		$WindowsMasterScript_To_Be_Copied = ($WindowsDriveLetter + $global:WindowsHardeningPath + "\windows_master_script.ps1")
		
		Copy-Item $WindowsMasterScript_To_Be_Copied -Destination $destination_Directory -Force
		
		if (test-path -Path "C:\Windows_Hardening\LegalNotice.ini")
		{
			"LegalNotice.ini file already present in $destination_Directory" >>$global:LogFile
		}
		else
		{
			"LegalNotice.ini file not present in $destination_Directory, hence copying" >>$global:LogFile
			Copy-Item $LegalNotice_To_Be_Copied -Destination $destination_Directory -Force
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckWindowsHardeningfolder function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Call Windows Hardening Script
# ------------------------------------------------------------------------

Function CallWindowsHardeningScript()
{       
    PrintDateTime
	"`nCalling Script to execute Automated Windows Hardening. Check $WindowsHardeningScriptLog for progress. "  >>$global:LogFile
	try
	{
		CheckWindowsHardeningfolder
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated Windows Node Hardening`t`t`t:In Progress" >>$global:SummaryLogFile
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		$Argument = "Enable"
		$global:WindowsHardeningStatus = Invoke-Expression "$global:WindowsHardeningScript $Argument"
		"Hardening status $global:WindowsHardeningStatus"  >>$global:LogFile
		if($global:WindowsHardeningStatus -match $false)
		{
			"`nExecution of $global:WindowsHardeningScript is completed but one or more stages Failed. Check $global:WindowsHardeningScriptLog for more details" >>$global:LogFile
			"`n Check C:\Windows_Hardening\log\* (latest log file) for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Windows Node Hardening`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile		
		}		
		elseif($global:WindowsHardeningStatus -match $true)
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`nExecution of $global:WindowsHardeningScript is completed and Windows Hardening is successful." >>$global:LogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Windows Node Hardening`t`t`t:Successful" >> $global:SummaryLogFile
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"----------------------------------------------- " >>$global:LogFile  
			"Summary of Automated Upgrade : " >> $global:LogFile
			Get-Content $global:SummaryLogFile >> $global:LogFile
			"----------------------------------------------- " >>$global:LogFile  
		}
		else
		{
			"`n[ERROR] unable to get the execution status of $global:WindowsHardeningScript and exiting from script." >>$global:LogFile
			"`n Check C:\Windows_Hardening\log\* (latest log file) for more details" >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			"`n$time : Automated Windows Node Hardening`t`t`t:Failed" >> $global:SummaryLogFile	
			"`n*********************************************************************************************************" >>$global:SummaryLogFile
			write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red			
		}
	}
	catch
	{
		$_  >>$global:LogFile
		"`nException in CallWindowsHardeningScript function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		"`n$time : Automated Windows Node Hardening`t`t`t:Failed" >> $global:SummaryLogFile	
		"`n*********************************************************************************************************" >>$global:SummaryLogFile
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red		
	}
}

#>

# ------------------------------------------------------------------------
#  Function to Delete Task from TaskScheduler 
# ------------------------------------------------------------------------
#

Function DeleteTaskfromTaskScheduler()
{       
    PrintDateTime
	"`n Deleting Task from Task Scheduler  " >>$global:LogFile
	try
	{
		$schedule = new-object -com("Schedule.Service")
        $schedule.connect()
        $tasks = $schedule.getfolder("\").gettasks(0)
        foreach ($t in $tasks)
		{
            $taskName=$t.Name
            if(($taskName -eq $global:EbidAutomationTaskName))
			{
				 "Task exist, hence deleting it." >> $global:LogFile
				schtasks /delete /tn $global:EbidAutomationTaskName /f >> $global:LogFile
            }
			<#elseif(($taskName -eq $global:EbidAutomationLoginTaskName))
			{
				 "Login Task exist, hence deleting it." >> $global:LogFile
				schtasks /delete /tn $global:EbidAutomationLoginTaskName /f >> $global:LogFile
            }#> 
        }			
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in DeleteTaskfromTaskScheduler function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details."
		Exit
	}
}
<#
function CheckTomcatRunStatus()
{
    $service_name="BOEXI40Tomcat"
    $curr_Service = get-service -Name $service_name
    if($curr_Service.Status -eq "Running")
    {			
        "Tomcat service started successfully and checking for Startup service line" >>$global:LogFile
        $BiInstallDir = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir).InstallDir
        $TomcatLogPath = $BiInstallDir+'tomcat\logs\stderr.log'    
        $CheckTime = 0
        $Found = $false
        while($CheckTime -lt 60)
        {
            $Content = Get-Content -path $TomcatLogPath
            if([bool]($Content -match "Server startup"))
            {
                "Server Startup found" >>$global:LogFile
                $Found = $true
                $Checktime = 100
            }
            else
            {
                "Server Startup not found and checking" >>$global:LogFile
                Start-Sleep -Seconds 20
                $Checktime += 1            
            }
        }
        if($Found -eq $true)
        {
			"Tomcat started completely." >>$global:LogFile
            return $true
        }
        else
        {
			"Tomcat did not started completely." >>$global:LogFile
            return $false
        }
    }
}
#>


# **********************************************************************
#	Main function starts here 
#	Variable initializations and log file creation
# **********************************************************************
# MAIN()

$global:Sysinfo = Get-WmiObject -Class Win32_ComputerSystem
$global:Time_Stamp=get-date -format yyyy-MM-dd_HH_mm_ss
$global:Date = get-date -format yyyy-MM-dd
$global:Time = get-date -format HH:mm:ss
$global:HostName = $sysinfo.Name
$global:ComputerName= ${Env:Computername}
$global:Sia = "Server Intelligence Agent ("+$global:ComputerName+")"
$global:ServicesList=@($global:Sia,"SQL Anywhere for SAP Business Intelligence","Apache Tomcat for BI 4","LCMSubversion")
$global:EbidAutomationTaskName = "EBIDAutomation"
$global:EbidAutomationLoginTaskName = "EBIDUpgradeProgress"
$global:PowershellVar = "powershell "
$global:DataCollectorPath = "data_Collector"
$global:DataCollectorStandalonePath = "data_collector_standalone"
$global:SSLPath = "SSL"
$global:AuditPath = "Audit"
$global:CertExpiryPath = "Certificate-expiry"
$global:InstallConfigPath = "install_config"
$global:BackupPath = "backup_restore"
$global:AllMediasAvailable = 0
$global:ServerFound = $False
$global:BiServerFound = $False  
$global:BiClientFound = $False
$global:ServersStatus = $False
$global:DiskSpaceStatus = $False
$global:PrerequisitesStatus = $False
$global:AddTaskStatus = $False
$global:AddLoginTaskStatus = $False
$global:ValidPassword = $False
$global:UpgradeStatus = $False
$global:NWClientUpgradeStatus = $False
$global:PostInstallStatus = $False
$global:LogDirectory = "C:\ebid\ebid_automation\log"
$global:MediaPath = "C:\ebid\ebid_medias"
$global:EBIDMedia = "C:\ebid\ebid_medias\Ericsson_Business_Intelligence_Deployment_Automation_Package_Media.iso"
$global:WindowsMedia = "C:\ebid\ebid_medias\WINDOWS_HARDENING.iso"
$global:SAPIQNWClientMedia = "C:\ebid\ebid_medias\SAP_IQ_Network_Client_Media.iso"
$global:MasterScriptConfigFile = "C:\ebid\ebid_automation\ebid_automation.ini"
$global:HousekeepingReportPath = "C:\Users\Administrator\Desktop\"
$global:HousekeepingReport = "C:\Users\Administrator\Desktop\ebid_housekeeping_report-*"
$global:HousekeepingScript = "housekeeping\ebid_housekeeping.ps1"
$global:PrerequisitesScript = "C:\ebid\ebid_automation\ebid_prerequisites.ps1"
$global:PrerequisitesScriptLog = "C:\ebid\ebid_automation\log\ebid_Prerequisites-*.log"
$global:BackupScript = "C:\ebid\backup_restore\ebid_backup_restore.ps1"
$global:BackupScriptLog = "C:\ebid\backup_restore\log\*"
$global:EbidAutomationTaskFile = $global:PowershellVar + "C:\ebid\ebid_automation\ebid_master_script.ps1 upgrade"
$global:EbidAutomationInstallServerTaskFile = $global:PowershellVar + "C:\ebid\ebid_automation\ebid_master_script.ps1 InstallServer"
$global:EbidAutomationInstallClientTaskFile = $global:PowershellVar + "C:\ebid\ebid_automation\ebid_master_script.ps1 InstallClient"
$global:EbidAutomationLoginTaskFile = "C:\ebid\ebid_automation\BIUpgradeProgress.ps1"
$global:UpgradeFolderPath = "C:\ebid\Upgrade"
$global:UpgradeScript = "C:\ebid\ebid_automation\ebid_upgrade.ps1"
$global:UpgradeScriptLog = "C:\ebid\ebid_automation\Log\ebid_install_upgrade-*"
$global:PostInstallScript = "C:\ebid\install_config\ebid_install_config.ps1"
$global:PostInstallScriptLog = "C:\ebid\install_config\Log\ebid_install_config_log-*.log"
$global:NWClientUpgradeScript = "C:\ebid\ebid_automation\ebid_networkClientUpgrade.ps1"
$global:NWClientUpgradeScriptLog = "C:\ebid\ebid_automation\log\ebid_networkClientUpgrade-*.log"
$global:UniverseReportPromotionScript = "C:\ebid\universe_report_promotion\UniverseReportPromotion.ps1"
$global:Universe_Report_Path = "universe_report_promotion"
$global:Eniq_Ini_Path = "ebid_automation\eniq.ini"
$global:WindowsHardeningScript = "C:\Windows_Hardening\windows_master_script.ps1"
$global:WindowsHardeningScriptLog = "C:\Windows_Hardening\log\Windows_Hardening-*.log"
$global:WindowsHardeningPath = "Windows_Hardening"
$global:SummaryLogFile = "C:\ebid\ebid_automation\log\ebid_automation_summary.log"
$global:HouseKeepingini = "C:\ebid\housekeeping\ebid_housekeeping.ini"
$global:LogFile = "C:\ebid\ebid_automation\log\ebid_automation_log-"+$global:Time_Stamp+".log"
$global:AuditConfigFile="C:\Audit\audit_config.ini"
$global:TempFile = "C:\ebid\ebid_automation\tmp.txt"
$global:NWClientVersionName = "SAP IQ Client Suite 16.1 SP05"
$global:NWClientExePath = "C:\ebf29977\setup.exe"
$ArrayDays=@("Sun","Mon","Tue","Wed","Thu","Fri","Sat")
$global:Upgrade = $False
$global:SSLScript = "C:\ebid\SSL\ebid_ssl_config.ps1"
$Script:ErrorCheck = 0
$global:DeleteLocalhost = $false
$global:InstallServer = $false
$global:InstallClient = $false
if(Test-Path -Path $global:MasterScriptConfigFile)
{
    foreach($line in Get-Content $global:MasterScriptConfigFile)
    {
        
        if($line -match "bi_server_media")
        {
            $LineSplit = "$line".split("=",2)
            $global:ServerMediaName = $LineSplit[1].Trim()
            $global:ServerMedia = "C:\ebid\ebid_medias\$global:ServerMediaName"	    	
        }
        elseif($line -match "bi_client_media")
        {
            $LineSplit = "$line".split("=",2)
            $global:ClientMediaName = $LineSplit[1].Trim()
            $global:ClientMedia = "C:\ebid\ebid_medias\$global:ClientMediaName"	
        }
    }
}
<#
# Create Log Files

if(Test-Path $LogDirectory)
{     
    $global:LogFile = New-Item $global:LogFile -ItemType File
	PrintDateTime
	if((Test-Path $global:SummaryLogFile) -and (($args[0] -ne "Upgrade") -OR ($args[0] -ne "InstallServer") -OR ($args[0] -ne "InstallClient")))
	{
		"----------------------------------------------- " >>$global:LogFile  
		"Previous Summary : " >> $global:LogFile
		Get-Content $global:SummaryLogFile >> $global:LogFile
		Remove-item $global:SummaryLogFile
        Start-Sleep -Seconds 5
        New-Item $global:SummaryLogFile -ItemType File >> $global:LogFile
		"----------------------------------------------- " >>$global:LogFile  		
	}
	elseif(!(Test-Path $global:SummaryLogFile))
	{
		$global:SummaryLogFile = New-Item $global:SummaryLogFile -ItemType File
	}
    "`nNew log files are created in C:\ebid\ebid_automation\log directory" >>$global:LogFile
}
else
{    
    New-Item -Path $LogDirectory -ItemType Directory | Out-Null
	$global:LogFile = New-Item C:\ebid\ebid_automation\log\ebid_automation_log-"$global:Time_Stamp".txt -ItemType File
	$global:SummaryLogFile = New-Item C:\ebid\ebid_automation\log\ebid_automation_summary.log -ItemType File
    PrintDateTime
    "`nNew log files are created in C:\ebid\ebid_automation\log directory" >>$global:LogFile
}

$Installini = (Get-ChildItem C:\ebid\install -Filter *.ini -Recurse | % { $_.FullName })
if(Test-Path -Path "C:\ebid\install\tmp.txt")
{
	$Content = Get-Content -Path "C:\ebid\install\tmp.txt"
	Set-Content -Path $Installini -Value $Content
	Remove-Item -Path "C:\ebid\install\tmp.txt" -Force
	Remove-Item -Path "C:\ebid\install\key.txt" -Force
	if(Test-Path -Path "C:\ebid\install_config\ebid_encryption_decryption.ps1")
    {
		powershell -command ". C:\ebid\install_config\ebid_encryption_decryption.ps1; EncryptEBIDFile -filepath $Installini -type "postinstall" ; "
	}
}

<# $install_dir = [bool]((Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir -ErrorAction SilentlyContinue).InstallDir)
If ($install_dir)
{
    $bi_install_dir=(Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir -ErrorAction SilentlyContinue).InstallDir
    $ccm_path = "$bi_install_dir" + "SAP BusinessObjects Enterprise XI 4.0\win64_x64\ccm.exe"
    $ccm_exists = Test-Path $ccm_path
    If ($ccm_exists -eq "True")
    {
        $bis=1
        "It's BIS server" >>$global:LogFile
    } 
}
else
{
    $bi_install_dir = [bool]((Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora' -Name Path -ErrorAction SilentlyContinue).Path)
    if($bi_install_dir -eq "True")
    {
        $bi_install_dir = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora' -Name Path -ErrorAction SilentlyContinue).Path
        $designer_path = "$bi_install_dir" + "SAP BusinessObjects Enterprise XI 4.0\win32_x86\designer.exe"
        $designer_exists = Test-Path $designer_path
        If ($designer_exists -eq "True")
        {
            $was=1    
            "It's OCS server" >>$global:LogFile        
        }
    }
}   
  

If ($bis -eq 1 -and $was -eq 1)
{
    $time = get-date -Format "yyyy MM dd HH:mm:ss"
	write-host "`n$time : [ERROR] Server and Client components installed in the same server and Upgrade cannot be perfomed. `n" -ForegroundColor Red    
    exit   
} 
#>

<#
foreach($line in Get-Content $global:MasterScriptConfigFile) 
{
	If($line -match "Windows_hardening")
	{
		$line_split = "$line".split("=",2)
		$global:Windows_hardening = $line_split[1].Trim()
	}	
}

foreach($line in Get-Content $global:MasterScriptConfigFile) 
{
	If($line -match "Universe_Report_Promotion")
	{
		$line_split = "$line".split("=",2)
		$global:Universe_Report_Promotion = $line_split[1].Trim()
	}	
}
foreach($line in Get-Content $global:MasterScriptConfigFile) 
{
	If($line -match "bi_install_client")
	{
		$line_split = "$line".split("=",2)
		$global:bisInstall = $line_split[1].Trim()
	}	
}
#>
#Check if BI 4.3 SP3 P3 is installed in Server

if(!(Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager") -AND !(Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora") -AND ($global:bisInstall -eq "No")){
	
	$global:BIVersionName = "BI platform 4.3 SP3 P3"
	
}

elseif(!(Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora") -AND ($global:bisInstall -eq "Yes")){
	$global:BIVersionName = "BI platform 4.3 Client Tools SP3 P3"
}
	
elseif((Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
{
	
	$global:BIVersionName = "BI platform 4.3 SP3 P3"

}
elseif(Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora")
{
	$global:BIVersionName = "BI platform 4.3 Client Tools SP3 P3"
} 

<#

if($args[0] -eq "Upgrade")
{
	Get-Content $global:SummaryLogFile >> $global:LogFile
	Remove-item $global:SummaryLogFile
	$time = get-date -Format "yyyy MM dd HH:mm:ss"
	
	"`n*********************************************************************************************************" >>$global:SummaryLogFile
	"`n$time : Automated Prerequisites`t`t`t`t:Successful" >> $global:SummaryLogFile
	"`n*********************************************************************************************************" >>$global:SummaryLogFile
													  
	PrintDateTime
	
	"`nScript called for Upgrade" >>$global:LogFile
	
	# Check if BI is already installed
	CheckIfBIInstalled
	
	#Verify and initiate upgrade if required
	InitiateBIUpgrade
	
	#Verify and initiate post installation if required
	InitiatePostInstallation
	
	#Revert Changes Made as part of Prerequisites
	CallPrerequisitesRevertScript
	
	#Verify and initiate Network Client upgrade if required
	InitiateNWClientUpgrade
	
	#univerpromotion
	if(($global:Universe_Report_Promotion -eq "Yes") -OR ($global:Universe_Report_Promotion -eq "Y"))
	{
		if(($global:bisInstall -eq "No") -OR ($global:bisInstall -eq "N") -OR ($global:bisInstall -eq "NO"))
		{
		InitiateUniversePromotion
		}
	}
	else
	{
		"`n Universe_Report_Promotion status is set to No and skipping it" >>$global:LogFile
	}
	
	#Enabling Windows Hardening on the server
	if((Test-Path -Path "C:\Ericsson\NetAnServer\Server") -AND (Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\Installer\Aurora") -AND !(Test-Path -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager"))
	{
		"`n Windows_hardening is skipped on NetAn server installed with BI client." >>$global:LogFile
	}	
	else
	{
		if(($global:Windows_hardening -eq "Yes") -OR ($global:Windows_hardening -eq "Y"))
		{
			"`n Windows_hardening status is set to Yes and executing.." >>$global:LogFile
			CallWindowsHardeningScript
		}
		else
		{
			"`n Windows_hardening status is set to No and skipping it" >>$global:LogFile
		}
	}	
	
	if($global:BiServerFound -eq $true)
	{
		# Check config file 
		CheckingConfigFile
	
		#Decrypt ini file
		DecryptingConfigFile
		
		#Resume Schedules
		$global:ScheduleAction="Resume"
		PauseResumeSchedules
	}

	#unmount Server Media
	UNMountMedia($global:ServerMedia)
	
	#unmount Client Media
	UNMountMedia($global:ClientMedia)
	
	#unmount EBID Automation Media
	UNMountMedia($global:EBIDMedia)
	
	#unmount Windows Media
	UNMountMedia($global:WindowsMedia)
	
	#unmount SAP IQ Client Media
	UNMountMedia($global:SAPIQNWClientMedia)
	
	if(Test-Path "C:\ebid\ebid_automation\tmp.txt")
	{
		try
		{
			Remove-Item -Path "C:\ebid\ebid_automation\tmp.txt" -Force >>$global:LogFile
		}
		catch
		{
			$_ >>$global:LogFile
		}
	}
	
	"`n*********************************************************************************************************" >>$global:SummaryLogFile
	"`nPlease close this window.. Check log file in C:\ebid\ebid_automation\log\ directory for more details" >>$global:SummaryLogFile
	"`n*********************************************************************************************************" >>$global:SummaryLogFile

	#Delete Task from TaskScheduler
	DeleteTaskfromTaskScheduler
	
	if($global:BiServerFound -eq $true)
	{
		if([bool](Get-ScheduledTask -TaskName "EBIDUpgradeProgress" -ErrorAction SilentlyContinue))
		{
			$global:EbidAutomationLoginTaskName = "EBIDUpgradeProgress"
			$testAction = New-ScheduledTaskAction  -Execute 'powershell.exe' -Argument '-windowstyle Maximized  C:\ebid\ebid_automation\BIUpgradeProgress.ps1'
			$testTrigger = New-ScheduledTaskTrigger -AtLogon
			$testSettings = New-ScheduledTaskSettingsSet -Compatibility Win8 
			Register-ScheduledTask -TaskName $global:EbidAutomationLoginTaskName -Action $testAction -Trigger $testTrigger -Settings $testSettings >> $global:LogFile
		}
		else
		{
			"EBIDUpgradeProgress task is already present" >>$global:LogFile
		}
		
		shutdown -r
	}
}
elseif($args[0] -eq "InstallServer")
{
    PrintDateTime
	"`nScript called for InstallServer" >>$global:LogFile    
    
	# Check if BI is already installed
	CheckIfBIInstalled

    #Verify and initiate install if required
	InitiateBIInstall  

    # Configuring HTTPS
    ConfigureHttps
	
    #Update housekeeping ini
    UpdateHouseKeepingObjId    
	
	$CheckTomcatStatus = CheckTomcatRunStatus
	"Server Startup Value $CheckTomcatStatus" >>$global:LogFile
	
	if($CheckTomcatStatus -eq $true)
	{
		#Verify and initiate post installation if required
		InitiatePostInstallation
	}
	else
	{
		"Tomcat Server didn't started completely and exiting from the script"
		exit
	}
	#Revert Changes Made as part of Prerequisites
	CallPrerequisitesRevertScript
	
	#Verify and initiate Network Client upgrade if required
	InitiateNWClientUpgrade
	
	#univerpromotion
	if(($global:Universe_Report_Promotion -eq "Yes") -OR ($global:Universe_Report_Promotion -eq "Y"))
	{
		if(($global:bisInstall -eq "No") -OR ($global:bisInstall -eq "N") -OR ($global:bisInstall -eq "NO"))
		{
		InitiateUniversePromotion
		}
	}
	else
	{
		"`n Universe_Report_Promotion status is set to No and skipping it" >>$global:LogFile
	}
	
	
	#Enabling Windows Hardening on the server
	if(($global:Windows_hardening -eq "Yes") -OR ($global:Windows_hardening -eq "Y"))
	{
		CallWindowsHardeningScript
	}
	else
	{
		"`n Windows_hardening status is set to No and skipping it" >>$global:LogFile
	}			
	
	if(Test-Path -Path "C:\ebid\TempPwd.ini")
    {
		Remove-Item -Path "C:\ebid\TempPwd.ini" -Force
	}
	
	
    #unmount Server Media
	UNMountMedia($global:ServerMedia)
	
	#unmount Client Media
	UNMountMedia($global:ClientMedia)
	
	#unmount EBID Automation Media
	UNMountMedia($global:EBIDMedia)
	
	#unmount Windows Media
	UNMountMedia($global:WindowsMedia)
	
	#unmount SAP IQ Client Media
	UNMountMedia($global:SAPIQNWClientMedia)
			
	$global:DeleteLocalhost = $true
	RestartTomcat
	
	CheckTomcatRunStatus
	
	"`n*********************************************************************************************************" >>$global:SummaryLogFile
	"`nPlease close this window.. Check log file in C:\ebid\ebid_automation\log\ directory for more details" >>$global:SummaryLogFile
	"`n*********************************************************************************************************" >>$global:SummaryLogFile
	
	#Delete Task from TaskScheduler
	DeleteTaskfromTaskScheduler
	
	if([bool](Get-ScheduledTask -TaskName "EBIDUpgradeProgress" -ErrorAction SilentlyContinue))
	{
		$global:EbidAutomationLoginTaskName = "EBIDUpgradeProgress"
		$testAction = New-ScheduledTaskAction  -Execute 'powershell.exe' -Argument '-windowstyle Maximized  C:\ebid\ebid_automation\BIUpgradeProgress.ps1'
		$testTrigger = New-ScheduledTaskTrigger -AtLogon
		$testSettings = New-ScheduledTaskSettingsSet -Compatibility Win8 
		Register-ScheduledTask -TaskName $global:EbidAutomationLoginTaskName -Action $testAction -Trigger $testTrigger -Settings $testSettings >> $global:LogFile
	}
	else
	{
		"EBIDUpgradeProgress task is already present" >>$global:LogFile
	}
	
	shutdown -r
	
}
elseif($args[0] -eq "InstallClient")
{
    PrintDateTime
	"`nScript called for InstallClient" >>$global:LogFile    
    
	# Check if BI is already installed
	CheckIfBIInstalled

    #Verify and initiate install if required
	InitiateBIInstall  

    #Verify and initiate post installation if required
	InitiatePostInstallation
	
	#Verify and initiate Network Client upgrade if required
	#InitiateNWClientUpgrade

    #Enabling Windows Hardening on the server
	if(!(Test-Path -Path "C:\Ericsson\NetAnServer\Server"))
	{
		if(($global:Windows_hardening -eq "Yes") -OR ($global:Windows_hardening -eq "Y"))
		{
			if(($global:ClientStatus -eq "Yes") -OR ($global:ClientStatus -eq "Y"))
			{
				CallWindowsHardeningScript
			}
			else
			{
				"`n It is not a OCS-without-Citrix server" >>$global:LogFile
			}	
		}
		else
		{
			"`n Windows_hardening status is set to No and skipping it" >>$global:LogFile
		}
    }
	
    $SAPIQInstallName = "SAPIQInstall"
    $SAPIQAction = "powershell -windowstyle hidden C:\ebid\ebid_automation\ebid_networkClientUpgrade.ps1"
    schtasks /create /ru Administrators /sc ONLOGON  /tn $SAPIQInstallName /tr $SAPIQAction /rl highest
    
    Start-ScheduledTask -TaskName $SAPIQInstallName
	if(Test-Path -Path "C:\ebid\TempPwd.ini")
    {
		Remove-Item -Path "C:\ebid\TempPwd.ini" -Force
	}									  

    #unmount Client Media
	UNMountMedia($global:ClientMedia)
	
	#unmount EBID Automation Media
	UNMountMedia($global:EBIDMedia)
	
	#unmount Windows Media
	UNMountMedia($global:WindowsMedia)

	#unmount SAP IQ Client Media
	#UNMountMedia($global:SAPIQNWClientMedia)
	
	#Revert Changes Made as part of Prerequisites
	CallPrerequisitesRevertScript
		
    #Delete Task from TaskScheduler
	DeleteTaskfromTaskScheduler
}
else
{
	
	# Check if BI is already installed
	CheckIfBIInstalled
	
	#Check the BI Version in the server
	CheckBIVersion
	
	# Check if Required Medias are available
	VerifyMediasAvailability
  	
    if(($global:BiServerFound -eq $true) -OR ($global:InstallServer -eq $true))
    {       
		if($global:Upgrade -eq $True)    
        {
			#Copy latest install config folder from Media
	        CopylatestInstallConfig
			
			#Copy latest housekeeping script
			CopylatestHousekeepingScript
            
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
		    write-host "`n$time : ***********************************************************************************" -ForegroundColor Green
		    $time = get-date -Format "yyyy MM dd HH:mm:ss"
		    write-host "`n$time : CMS password Validation : In Progress." -ForegroundColor Green
		    
		    # Check config file 
		    CheckingConfigFile
	
		    #Decrypt ini file
		    DecryptingConfigFile
	
		    #Validate CMS Password
		    ValidateCMSPwd
		}
		
        # Take userInput for BIS IP
	    GetBISIPAddress
		
	    # Take userInput for Eniq IP
	    GetENIQIPAddress	
	    	
	    # Update Master ini file
	    UpdateMasterIni

        if($global:Upgrade -eq $True)    
        {    
         	if(($global:Universe_Report_Promotion -eq "Yes") -OR ($global:Universe_Report_Promotion -eq "Y") -OR ($global:Universe_Report_Promotion -eq "YES"))
	{   
	    CheckEniqIni
		if (test-path -Path "C:\ebid\ebid_automation\eniq.ini") 
	{
        Eniqloginserver
		EniqUserLogin
		Eniqdetails
		}
	}

            #Pause Schedules
		    $global:ScheduleAction="Pause"
		    
		    # Take BI content Backup 
		    BIContentBackup            
        }
    }
    elseif(($global:BiClientFound -eq $true) -OR ($global:InstallClient -eq $true))
    {
		if($global:Upgrade -eq $True)    
        {
			#Copy latest install config folder from Media
	        CopylatestInstallConfig
		}
        #Input Required for Client
		GetBISFQDN
		
		if(($global:ClientStatus -eq "Yes") -OR ($global:ClientStatus -eq "Y"))
		{
			# Take userInput for Eniq IP
			GetENIQIPAddress
			
			# Take RDP input
			$TempFile = "C:\ebid\TempPwd.ini"
			if(Test-Path -Path $TempFile)
			{
				Clear-Content -Path  $TempFile
			} 
			GetRDPInputs
			# Update Master ini file
			UpdateMasterIniClientStandalone
		}					  
    }    

	# Check if BI Heath is fine. 
	CheckHealthStatus

    if($global:InstallServer -eq $true)
    {
        CopyIIIni        
        ValidateInput 
        GetExtraInputs 
		GetRDPInputs					  
        UpdateInstallIni      
        UpdateHousekeepingini  
		if(($global:Universe_Report_Promotion -eq "Yes") -OR ($global:Universe_Report_Promotion -eq "Y") -OR ($global:Universe_Report_Promotion -eq "YES"))
	{   
	    CheckEniqIni
		if (test-path -Path "C:\ebid\ebid_automation\eniq.ini") 
	{
        Eniqloginserver
		EniqUserLogin
		Eniqdetails
		}
	}
		
  	
    }
    elseif($global:InstallClient -eq $true)
    {
        CopyIIIni
    }

    if($global:Upgrade -eq $True)    
    {
        # copy ini files for Upgrade
	    CopyIniFiles
    }

	
	#Call Prerequisites Script.
	CallPrerequisitesScript	
	
	# Add Task In TaskScheduler to start the upgrade automatically after reboot.
	AddTaskInTaskScheduler

	# Reboot the Server.
	RebootServer
}#>