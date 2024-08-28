$global:MediaPath = "C:\ebid\ebid_medias"
$global:AllMediasAvailable = 0
$global:LogFile = "C:\ebid\ebid_automation\log\ebid_automation_log-"+$global:Time_Stamp+".log"
$global:EBIDMedia = "C:\ebid\ebid_medias\Ericsson_Business_Intelligence_Deployment_Automation_Package_Media.iso"
$global:SAPIQNWClientMedia = "C:\ebid\ebid_medias\SAP_IQ_Network_Client_Media.iso"
$global:BiServerFound = $True
$global:BiClientFound = $True 
$global:InstallServer = $false
$global:InstallClient = $false
$global:WindowsMedia = "C:\ebid\ebid_medias\WINDOWS_HARDENING.iso"
$global:ServerMedia = "C:\ebid\ebid_medias\$global:ServerMediaName"

Function PrintDateTime()
{    
    "----------------------------------------------- " >>$global:LogFile 
     Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$global:LogFile
    "----------------------------------------------- " >>$global:LogFile      
}

#Function to verify if all the required media's are available
#------------------------------------------------------------------------

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
			"`n$global:MediaPath not found" >>$global:LogFile
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

Describe "VerifyMediasAvailability"{
   
          It "VerifyMediaAvailability" {
              VerifyMediasAvailability | Should Be
    }
	
}