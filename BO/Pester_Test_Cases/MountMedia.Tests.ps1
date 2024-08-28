$global:Time_Stamp=get-date -format yyyy-MM-dd_HH_mm_ss
$global:LogFile = "C:\ebid\ebid_automation\log\ebid_automation_log-"+$global:Time_Stamp+".log"

$Media = "C:\ebid\ebid_medias\Ericsson_Business_Intelligence_Deployment_Automation_Package_Media.iso"
$time = get-date -Format "yyyy MM dd HH:mm:ss"
Function PrintDateTime()
{    
    "----------------------------------------------- " >>$global:LogFile 
     Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$global:LogFile
    "----------------------------------------------- " >>$global:LogFile      
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

Describe "MountMedia" {
	It "MountMedia" {
		MountMedia | Should Be " "
    }
}