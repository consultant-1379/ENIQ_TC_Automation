Function to Get User Input for Client
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
