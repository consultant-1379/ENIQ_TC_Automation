function check_If_Admin 
{
	#Checking if Administrator
	
	PrintDateTime
	"`nChecking if Administrator" >>$global:LogFile
	try
	{
		$user = [Security.Principal.WindowsIdentity]::GetCurrent();
		$CheckUser  = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
		if($CheckUser)
		{
			check_If_NonAdmin
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Please log in as Administrator to proceed with BI Upgrade. `n" -ForegroundColor Red
			write-host "`n$time : [ERROR] All non-administrator users should log off from the server. `n" -ForegroundColor Red
			write-host "`n$time : FAILURE!!" -ForegroundColor Red
			EXIT (1)
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in check_If_Admin function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

Describe "tocheckif_admin
{
   It "check_If_Admin" {
       check_If_Admin | Should be "Administrator"
   
   } 

} #Describe function closed
