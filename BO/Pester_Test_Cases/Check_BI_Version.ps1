Function to check the BI version
# ------------------------------------------------------------------------

Function CheckBIVersion ()
{
	PrintDateTime
	"`nChecking the BI version" >>$global:LogFile
	try
	{
		if([bool](Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-Object {$_.DisplayName -Match $global:BIVersionName}))
		{
			"`nServer already has BI Version: $global:BIVersionName " >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : $global:BIVersionName is already installed.`n" -ForegroundColor Green
			Exit
		}
		else
		{
			"`nServer doesnt have BI Version: $global:BIVersionName Proceeding further" >>$global:LogFile
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckBIVersion function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}
