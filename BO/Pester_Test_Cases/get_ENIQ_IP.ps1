Function to Get ENIQ IP 
# -----------------------------------------------------------------------------------

Function GetENIQIPAddress()
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
