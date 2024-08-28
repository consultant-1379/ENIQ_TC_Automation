Function to identify the Deployment Type (BI Server or BI client)
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

