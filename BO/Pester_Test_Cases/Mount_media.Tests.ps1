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

Describe "Mount Media"
  { 
              It "Mount Media" {
              checkifadmin | Should Be "Media present" 
    }
}