
$global:Time_Stamp=get-date -format yyyy-MM-dd_HH_mm_ss
$global:LogFile = "C:\ebid\ebid_automation\log\ebid_automation_log-"+$global:Time_Stamp+".log"
$global:BiInstallDir = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir).InstallDir

Function PrintDateTime()
{    
    "----------------------------------------------- " >>$global:LogFile 
     Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$global:LogFile
    "----------------------------------------------- " >>$global:LogFile      
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
			#CallUpgradeScript
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

Describe "InitiateBIUpgrade" {
	It "InitiateBIUpgrade" {
		InitiateBIUpgrade | Should Be " "
    }
}