#------------------------------------------------------------------------
#Print date and time in the log file
#------------------------------------------------------------------------
function PrintDateTime()
{    
    "----------------------------------------------- " >>$PreLog
    Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$PreLog
    "----------------------------------------------- " >>$PreLog
}

Function PrintActionAndResetVariables()
{
	$script:output_obj = New-Object System.Object	
}

#------------------------------------------------------------------------
#Changing the server settings to Auto-Assign
#------------------------------------------------------------------------
function CallGetconfScript()
{	
	PrintActionAndResetVariables
	$scriptPath = "C:\ebid\install_config\ebid_install_config.ps1"
    $GetConfValue = "Fail"
	if(Test-Path -Path $scriptPath)
	{
		$argumentList = "autogetconf"
        $BISCheck = [bool](Get-ItemProperty -Path "HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4*\config Manager" -ErrorAction SilentlyContinue)
        if($BISCheck)
        {
            $output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Preupgrade Configuration Backup"
        }		
        else
        {
            $output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Preupgrade Configuration Backup Client"    
        }
        try
        {
		    $GetConfValue = Invoke-Expression "$scriptPath $argumentList"
        }
        catch
        {
            $_ >>$PreLog
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Post installation script failed with getconf argument" -ForegroundColor Red
            $output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        }
		if($GetConfValue -eq "success")
		{			
			$Script:TaskValue = $Script:TaskValue + 1
			"`nPreupgrade Configuration Backup Successful" >>$PreLog
			$output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
		}
		else
		{
			"`nPreupgrade Configuration Backup: failed" >>$PreLog
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			$output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"	
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Post installation script failed with getconf argument" -ForegroundColor Red		
		}
	}
	else
	{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] $scriptPath is not present"
			$output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Post installation script failed with getconf argument" -ForegroundColor Red
	}
	$script:output_table += $script:output_obj
}

#------------------------------------------------------------------------
#Checking the status of windows defender
#------------------------------------------------------------------------
function GetWindowsDefenderStatus()
{
    PrintDateTime
    "Status of windows defender" >>$PreLog
    try
    {
        Get-MpPreference >>$PreLog
        $DefenderCheck = (Get-MpPreference | Select-Object -Property DisableRealtimeMonitoring).DisableRealtimeMonitoring
    }
    catch
    {
        "Unable to access windows defender" >>$PreLog
        $_ >>$PreLog        
    }        
    if($DefenderCheck)
    {
        "Status of windows defender : Disabled" >>$PreLog
    }
    else
    {
        "Status of windows defender : Enabled" >>$PreLog        
    }  
    return $DefenderCheck
}

#------------------------------------------------------------------------
#Turn of windows defender
#------------------------------------------------------------------------
function TurnoffWindowsDefender()
{
    PrintDateTime
    "Turning of windows defender" >>$PreLog
	PrintActionAndResetVariables
	#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn Off Windows Defender"
    try
    {
        Set-MpPreference -DisableRealtimeMonitoring $true
    }
    catch
    {
        $_ >>$PreLog}
    try
    {
        $Status = GetWindowsDefenderStatus        
        if($Status)
        {            
            "Turning off windows defender successful" >>$PreLog
			#$Script:TaskValue = $Script:TaskValue + 1
			#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
        }
        else
        {
            "Turning off windows defender unsuccessful" >>$PreLog
			#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        }		
    }
    catch
    {
        $_ >>$PreLog
		#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
    }    
	#$script:output_table += $script:output_obj
}

#------------------------------------------------------------------------
#Turn on windows defender
#------------------------------------------------------------------------
function TurnonWindowsDefender()
{
    PrintDateTime
    "Turning on windows defender" >>$PreLog
	PrintActionAndResetVariables
	#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn On Windows Defender"
    try
    {
        Set-MpPreference -DisableRealtimeMonitoring $false
    }
    catch
    {
        $_ >>$PreLo
    }
    try
    {
        $Status = GetWindowsDefenderStatus        
        if($Status)
        {
            "Turning on windows defender unsuccessful" >>$PreLog
			#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
        }
        else
        {
            "Turning on windows defender successful" >>$PreLog
            #$Script:TaskValue = $Script:TaskValue + 1
			#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        }
    }
    catch
    {
        $_ >>$PreLog
		#$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
    }    
	#$script:output_table += $script:output_obj
}

#------------------------------------------------------------------------
#Turn of User account control settings
#------------------------------------------------------------------------

function TurnOffUAC()
{
    PrintDateTime
    try
    {
		PrintActionAndResetVariables
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn Off User Account Control settings"
        $UACLevel = (Get-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin).ConsentPromptBehaviorAdmin
        if($UACLevel -eq "0")
        {
            "User Account control settings level is set to 0" >>$PreLog
        }
        else
        {
            "User Account control settings level is set to 2 and changing it to 0" >>$PreLog
            Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0   
        }    
        $UACLevel = (Get-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin).ConsentPromptBehaviorAdmin
        if($UACLevel -eq 0)
        {
            $Script:TaskValue = $Script:TaskValue + 1
            "Setting UAC level to 0 successful" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
        }
        else
        {
            "Setting UAC level to 0 failed" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Turning off user account control failed" -ForegroundColor Red
        }
    }
    catch
    {
        "Setting User Account control settings level to 0 failed due to exception">>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $_ >>$PreLog
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Turning off user account control failed" -ForegroundColor RedWrite-Host "" -ForegroundColor Red
    }         
    $script:output_table += $script:output_obj
}


#------------------------------------------------------------------------
#Turn on User account control settings
#------------------------------------------------------------------------

function TurnOnUAC()
{
    PrintDateTime
    try
    {
		PrintActionAndResetVariables
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn On User Account Control settings"
        $UACLevel = (Get-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin).ConsentPromptBehaviorAdmin
        if($UACLevel -eq "2")
        {
            "User Account control settings level is set to 2" >>$PreLog
        }
        else
        {
            "User Account control settings level is set to 0 and changing it to 2" >>$PreLog
            Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 2   
        }    
        $UACLevel = (Get-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin).ConsentPromptBehaviorAdmin
        if($UACLevel -eq 2)
        {
            $Script:TaskValue = $Script:TaskValue + 1
            "Setting UAC level to 2 successful" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
        }
        else
        {
            "Setting UAC level to 2 failed" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Turning on user account control failed" -ForegroundColor Red
        }
    }
    catch
    {
        "Setting User Account control settings level to 2 failed due to exception">>$PreLog
        $_ >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Turning on user account control failed" -ForegroundColor Red
    } 
	$script:output_table += $script:output_obj	
}

#------------------------------------------------------------------------
# Turn On DEP services
#------------------------------------------------------------------------
function TurnOnDEP()
{
    PrintDateTime
	PrintActionAndResetVariables
    "Turning on Data Execution Prevention for essential windows programs and services" >>$PreLog
	$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn on Data Execution Prevention"
    try
    {
        bcdedit.exe /set nx Optin | Out-Null
    }
    catch
    {
        "Turning on Data Execution Prevention for essential windows programs and services is failed due to exception" >>$PreLog
        $_ >>$PreLog
        $script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Turning on data execution prevention failed" -ForegroundColor Red
    }        
    if($?)
    {
        $Script:TaskValue = $Script:TaskValue + 1
        "Turning on Data Execution Prevention for essential windows programs and services is successful" >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
    }
    else
    {
        "Turning on Data Execution Prevention for essential windows programs and services is unsuccessful" >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Turning on data execution prevention failed" -ForegroundColor Red
    }
	$script:output_table += $script:output_obj
}

#------------------------------------------------------------------------
# Turn Off DEP services
#------------------------------------------------------------------------
function TurnOfDEP()
{
    PrintDateTime
    "Turning off Data Execution Prevention for essential windows programs and services" >>$PreLog
	PrintActionAndResetVariables
	$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn off Data Execution Prevention"
    try
    {
        bcdedit.exe /set nx OptOut | Out-Null
    }
    catch
    {
        $_ >>$PreLog
        $script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Turning off data execution prevention failed" -ForegroundColor Red
    }        
    if($?)
    {
        $Script:TaskValue = $Script:TaskValue + 1
        "Turning off Data Execution Prevention for essential windows programs and services is successful" >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
    }
    else
    {
        "Turning off Data Execution Prevention for essential windows programs and services is unsuccessful" >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Turning off data execution prevention failed" -ForegroundColor Red
    }
	$script:output_table += $script:output_obj
}


function TurnOnFirewall()
{
    PrintDateTime
    $FirewallValue = 0
    $PreFirewallBackUp = "C:\ebid\ebid_automation\PreFirewallBackup.txt"
	PrintActionAndResetVariables
	$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn On Firewall"
    if(Test-Path -Path $PreFirewallBackUp)
    {        
        foreach($SourceFolder in Get-Content  $PreFirewallBackUp)
        {   
            try
            {        
                If($SourceFolder -match "Domain")
                {                                
          	       	$LineSplit = "$SourceFolder".split("=",2)
                    $Value = $LineSplit[1].Trim()                
                    Set-NetFirewallProfile -Profile Domain -Enabled $Value    
                    $FirewallValue = $FirewallValue +1                  
					"`nRollback of Domain profile to $Value is successful" >>$PreLog
                }
                elseif($SourceFolder -match "Private")
                {
                    $LineSplit = "$SourceFolder".split("=",2)
                    $Value = $LineSplit[1].Trim()
                    Set-NetFirewallProfile -Profile Private -Enabled $Value                    
                    $FirewallValue = $FirewallValue +1
					"`nRollback of Private profile to $Value is successful" >>$PreLog
                }
                elseif($SourceFolder -match "Public")
                {
                    $LineSplit = "$SourceFolder".split("=",2)
                    $Value = $LineSplit[1].Trim()
                    Set-NetFirewallProfile -Profile Public -Enabled $Value                    
                    $FirewallValue = $FirewallValue +1
					"`nRollback of Public profile to $Value is successful" >>$PreLog
                }
            }
            catch
            {
                "Error when turning on firewall profiles" >>$PreLog
                $_ >>$PreLog                
            }
        }                  
        if($FirewallValue -eq 3)      
        {
            "All firewall profiles rollback successful" >>$PreLog
            $Script:TaskValue = $Script:TaskValue + 1
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
        }
		else
		{
			"Turning on all firewall profiles failed. Please turn on firewall manually" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Turning on firewall failed" -ForegroundColor Red
		}
    }
    else
    {      
        "Firewall backup file not found and turning on all firewall profiles" >>$PreLog
        try
        {
            Set-NetFirewallProfile -All -Enabled True 
            $Script:TaskValue = $Script:TaskValue + 1           
            "Rollbacking of all firewall profiles is successful" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
        }
        catch
        {            
            "Rollbacking of all firewall profiles failed" >>$PreLog
            $_ >>$PreLog            
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Turning on firewall failed" -ForegroundColor Red
        }
    }
	$script:output_table += $script:output_obj
}

#-------------------------------------------------------------
# Turning off the firewall based on the Firewall Backupfile
#-------------------------------------------------------------

function TurnOffFirewall()
{
    PrintDateTime
    $PreFirewallBackUp = "C:\ebid\ebid_automation\PreFirewallBackup.txt"
	PrintActionAndResetVariables
	$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn Off Firewall"
    if(Test-Path -Path $PreFirewallBackUp)
    {
        Remove-Item -Path $PreFirewallBackUp -Force -ErrorAction SilentlyContinue
    }
    try
    {
        $FirewallValues =  Get-NetFirewallProfile -All
        foreach($FirewallProfile in $FirewallValues)
        {
            $FirewallName = $FirewallProfile.Name
            $FirewallEnable = $FirewallProfile.Enabled
            "$FirewallName = $FirewallEnable" >>$PreFirewallBackUp
            if($FirewallProfile.Enabled -ne "False")
            {                
                "$FirewallName firewall profile is Enabled and Turning off the profile" >>$PreLog
                try
                {
                    Set-NetFirewallProfile -Name $FirewallName -Enabled False 
                    $FirewallValue = $FirewallValue +1                   
                    "Disabling of $FirewallName profile is successful" >>$PreLog
                }
                catch
                {                    
                    "Disabling of $FirewallName profile is failed and hence exiting from the script" >>$PreLog
                    $_ >>$PreLog                    
                }
            }
            else
            {
                "$FirewallName is Disabled" >>$PreLog
                $FirewallValue = $FirewallValue +1
            }
        }                 
        if($FirewallValue -eq 3)      
        {
            "All firewall profiles disabling successful" >>$PreLog
            $Script:TaskValue = $Script:TaskValue + 1
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
        }
		else
		{
			"Turninf of all firewall profiles failed. Please turn off all firewall profiles manually" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Turning off firewall failed" -ForegroundColor Red
		}
    }
    catch
    {        
        "Error occured while Disabling the firewall and hence exiting from the script" >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"    
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Turning off firewall failed" -ForegroundColor Red    
    }    
	$script:output_table += $script:output_obj
}

function ClearTemp()
{
    try
    {
        Remove-Item -Path $env:TEMP -Recurse -Force -ErrorAction SilentlyContinue
    }
    catch
    {
        "Failed to clear temp directory" >>$PreLog
        $_ >>$PreLog
    }
}

function StopVolumeShadowCopy()
{
	try
	{
		PrintActionAndResetVariables
		$VSCBackup = "C:\ebid\ebid_automation\VSCBackup.txt"
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Stop Volume Shadow Copy"
		$VSCCheck = (Get-Service -DisplayName "Volume Shadow Copy" -ErrorAction SilentlyContinue).Status
		if($VSCCheck -eq "Stopped")
		{
			"Volume Shadow Copy service already stopped" >>$PreLog
			$Script:TaskValue = $Script:TaskValue + 1
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
		}
		else
		{
			$VSCCheck >>$VSCBackup
			Stop-Service -DisplayName "Volume Shadow Copy"
			$TimeTaken = 0
			$VSCCheck = (Get-Service -DisplayName "Volume Shadow Copy" -ErrorAction SilentlyContinue).Status
			while($VSCCheck -ne "Stopped")
			{   				
				$TimeVar = Get-Date -Format 'yyyy.MM.dd.HH.mm.ss'     
				"$TimeVar Stopping Volume Shadow Copy, Please wait......" >>$Log        
				if($TimeTaken -lt 300)
				{
					Start-Sleep -Seconds 5
					$TimeTaken = $TimeTaken + 5
					$VSCCheck = (Get-Service -DisplayName "Volume Shadow Copy" -ErrorAction SilentlyContinue).Status
				}					
				elseif($TimeTaken -ge 300)
				{
					$VSCCheck = "Stopped"
				}				
			}
			if((Get-Service -DisplayName "Volume Shadow Copy" -ErrorAction SilentlyContinue).Status -eq "Stopped")
			{
				"Stopping Volume Shadow Copy is successful" >> $PreLog								
				$Script:TaskValue = $Script:TaskValue + 1
				$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
			}
			else
			{
				"Stopping Volume Shadow Copy failed" >> $PreLog
				$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
                $time = get-date -Format "yyyy MM dd HH:mm:ss"
				write-host "`n$time : [ERROR] Stopping Volume Shadow Copy service failed" -ForegroundColor Red
			}
		}			
	}
	catch
	{
		$_ >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Stopping Volume Shadow Copy service failed" -ForegroundColor Red
	}
	$script:output_table += $script:output_obj
}

function StartVolumeShadowCopy()
{
	try
	{
		PrintDateTime
		"Starting Volume Shadow Copy" >>$PreLog
		PrintActionAndResetVariables
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Rollback Volume Shadow Copy"
		if(Test-Path -Path "C:\ebid\ebid_automation\VSCBackup.txt")
		{
			$VSCBackupValue = Get-Content -Path "C:\ebid\ebid_automation\VSCBackup.txt"
			if($VSCBackupValue -eq "Running")
			{
				Start-Service -DisplayName "Volume Shadow Copy"
				$TimeTaken = 0
				$VSCCheck = (Get-Service -DisplayName "Volume Shadow Copy" -ErrorAction SilentlyContinue).Status
				while($VSCCheck -ne "Running")
				{   				
					$TimeVar = Get-Date -Format 'yyyy.MM.dd.HH.mm.ss'     
					"$TimeVar Stopping Volume Shadow Copy, Please wait......" >>$Log        
					if($TimeTaken -lt 300)
					{
						Start-Sleep -Seconds 5
						$TimeTaken = $TimeTaken + 5
						$VSCCheck = (Get-Service -DisplayName "Volume Shadow Copy" -ErrorAction SilentlyContinue).Status
					}					
					elseif($TimeTaken -ge 300)
					{
						$VSCCheck = "Running"
					}				
				}
				if((Get-Service -DisplayName "Volume Shadow Copy" -ErrorAction SilentlyContinue).Status -eq "Running")
				{
					"Starting Volume Shadow Copy is successful" >> $PreLog								
					$Script:TaskValue = $Script:TaskValue + 1
					$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
				}
				else
				{
					"Starting Volume Shadow Copy failed" >> $PreLog
					$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
                    $time = get-date -Format "yyyy MM dd HH:mm:ss"
					write-host "`n$time : [ERROR] Starting Volume Shadow Copy service failed" -ForegroundColor Red
				}
			}
		}
		else
		{
			"No Volume Shadow Copy backup file found and service status remains same" >>$PreLog
			$Script:TaskValue = $Script:TaskValue + 1
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
		}	
		if(Test-Path -Path "C:\ebid\ebid_automation\VSCBackup.txt")
		{
			Remove-Item -Path "C:\ebid\ebid_automation\VSCBackup.txt" -Force -ErrorAction SilentlyContinue
		}
	}
	catch
	{
		$_ >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Starting Volume Shadow Copy service failed" -ForegroundColor Red
	}
	$script:output_table += $script:output_obj
}

function StopWindowsUpdate()
{
	try
	{
		PrintActionAndResetVariables		
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Disabling Windows Update"
		"Disabling Windows Update" >>$PreLog
		$WinUpdate = sc.exe config wuauserv start= disabled
		if($WinUpdate -match "SUCCESS")
		{
			"Disabling Windows Update is successful" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
			$Script:TaskValue = $Script:TaskValue + 1
		}
		else
		{
			"Disabling Windows Update is failed" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Stopping windows update failed" -ForegroundColor Red
		}
	}
	catch
	{
		$_ >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Stopping windows update failed" -ForegroundColor Red
	}
	$script:output_table += $script:output_obj
}

function StartWindowsUpdate()
{
	try
	{
		PrintActionAndResetVariables		
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Enabling Windows Update"
		$WinUpdate = sc.exe config wuauserv start= auto
		"Enabling Windows Update" >>$PreLog
		if($WinUpdate -match "SUCCESS")
		{
			"Enabling Windows Update is successful" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
			$Script:TaskValue = $Script:TaskValue + 1
		}
		else
		{
			"Enabling Windows Update is failed" >>$PreLog
			$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
            $time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Starting windows update failed" -ForegroundColor Red
		}
	}
	catch
	{
		$_ >>$PreLog
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Failed"
        $time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Starting windows update failed" -ForegroundColor Red
	}
	$script:output_table += $script:output_obj
}
#------------------------------------------------------------------------
#             MAIN (SCRIPT STARTS HERE)
#------------------------------------------------------------------------

$TimeStamp = Get-Date -Format yyyy-MM-dd_HH_mm_ss
$PreLog = "C:\ebid\ebid_automation\log\ebid_prerequisite-$TimeStamp.log"
$Script:TaskValue = 0
$script:output_table = @()
$global:MasterScriptConfigFile = "C:\ebid\ebid_automation\ebid_automation.ini"
#------------------------------------------------------------------------
#Checking if user has given correct argument or not
#------------------------------------------------------------------------
if($args.Count -lt 1)
{
    $time = get-date -Format "yyyy MM dd HH:mm:ss"
	write-host "`n$time : [ERROR] No arguments are given when running the script. Please use anyone of the following arguments to run the script Enable, Disable." -ForegroundColor Red
    exit
}
elseif($args.Count -gt 1)
{
    $time = get-date -Format "yyyy MM dd HH:mm:ss"
	write-host "`n$time : [ERROR] Only one argument should be given when running the script. Please use Enable or Disable arguments and try running the script." -ForegroundColor Red
    exit
}

if(($args -ne "Enable") -AND ($args -ne "Disable"))
{
    $time = get-date -Format "yyyy MM dd HH:mm:ss"
	write-host "`n$time : [ERROR] $args is an Invalid argument. Enable, Disable are valid arguments" -ForegroundColor Red
    exit
}
else
{
    #Write-Host "`n Script is running with $args argument"
}
 Set-ExecutionPolicy RemoteSigned -Confirm:$false -Force
if($args -eq "Enable")
{
	foreach($line in Get-Content $global:MasterScriptConfigFile) 
	{
		If($line -match "Windows_hardening")
		{
			$line_split = "$line".split("=",2)
			$global:Windows_hardening = $line_split[1].Trim()
		}	
	}
    #$GetDefenderStatus = GetWindowsDefenderStatus
    #TurnonWindowsDefender
    TurnOnUAC    
    TurnOfDEP    
    PrintDateTime
	if(($global:Windows_hardening -eq "Yes") -OR ($global:Windows_hardening -eq "Y"))
	{
		"`n Windows_hardening status is set to Yes and firewall will be turned on" >>$PreLog
		PrintActionAndResetVariables
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Action" -value "Turn On Firewall"
		$script:output_obj | Add-Member -type NoteProperty -ErrorAction SilentlyContinue -name "Status" -value "Successful"
		$script:output_table += $script:output_obj
		$Script:TaskValue = $Script:TaskValue + 1
	}
	else
	{
		"`n Windows_hardening status is set to No and firewall will be reverted to original state" >>$PreLog
		TurnOnFirewall		
	}
	StartVolumeShadowCopy
	StartWindowsUpdate
    PrintDateTime
    "Total pre-requisites rollback successfully $Script:TaskValue " >>$PreLog
	$output_table | Format-Table -Wrap -AutoSize
	$output_table | Format-Table -Wrap -AutoSize >>$PreLog
    if($Script:TaskValue -eq 5)
    {
        "All Pre-Requisites rollback successfully" >>$PreLog
        return $true
    }
    else
    {
        "All Pre-Requisites failed to rollback" >>$PreLog
        return $False
    }    
}
elseif($args -eq "Disable")
{
    #$GetDefenderStatus = GetWindowsDefenderStatus
    #TurnoffWindowsDefender
    TurnOffUAC    
    TurnOnDEP
    TurnOffFirewall
	if($global:Upgrade -eq $True)
	{
		CallGetconfScript	
	}	
    PrintDateTime
	ClearTemp
	StopVolumeShadowCopy
	StopWindowsUpdate
    "Total pre-requisites executed successfully $Script:TaskValue " >>$PreLog
	$output_table | Format-Table -Wrap -AutoSize >>$PreLog	
	$output_table | Format-Table -Wrap -AutoSize
	if(($global:InstallServer -eq $True) -OR ($global:InstallClient -eq $True))
	{	
		if($Script:TaskValue -eq 5)
		{            
			"All Pre-Requisites meet successfully" >>$PreLog		
			return $true
		}
		else
		{
			"All Pre-Requisites not meet successfully" >>$PreLog
			return $false
		} 
	}
	else
	{
        "`nFor Preupgrade Configuration Backup Action, Please check C:\ebid\install_config\ebid_install_config_log-<current date> log file for more details.">>$PreLog
		if($Script:TaskValue -eq 6)
		{            
			"All Pre-Requisites meet successfully" >>$PreLog		
			return $true
		}
		else
		{
			"All Pre-Requisites not meet successfully" >>$PreLog
			return $false
		} 
	}	
}