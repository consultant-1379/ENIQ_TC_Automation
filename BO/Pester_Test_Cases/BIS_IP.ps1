Function to Get BIS IP 
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
