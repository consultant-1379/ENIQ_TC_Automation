$global:InstallServer = $false
#$global:LogFile = "C:\ebid\ebid_automation\log\ebid_automation_log-"+$global:Time_Stamp+"
$global:Time_Stamp=get-date -format yyyy-MM-dd_HH_mm_ss

# ------------------------------------------------------------------------
#  Function to Mount Media
# ------------------------------------------------------------------------

Function MountMedia($Media)
{
	
	
	try
	{			
		if((Get-DiskImage -ImagePath $Media).Attached)
		{
			
			$DriveLetter = (Get-DiskImage -ImagePath $Media | Get-Volume).DriveLetter
			$DriveLetter = $DriveLetter + ":\"      
		}
		else
		{
			"Media: $Media Not mounted and mounting..." >>$global:LogFile
			$DriveLetter = (Mount-DiskImage -ImagePath $Media -PassThru | Get-Volume).DriveLetter        
			$DriveLetter = $DriveLetter + ":\"        
		}  
		
		return $DriveLetter
	}
	catch
	{
		
		write-host "[ERROR] : Exception in MountMedia function for $Media." -ForegroundColor Red
		Exit
	}
}

<#Describe "MountMedia" {
	It "MountMedia" {
		MountMedia | Should Be " mounted"
    } #>

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
Describe "CopyIIIni" {
	It "CopyIIIni" {
		CopyIIIni | Should Be 
		}
}
