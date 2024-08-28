LOGOFF Non Administrator user
# **************************************************************************************

function handle_NonAdmin_Users ($user, $session_Id) 
{
	PrintDateTime
	"`nHandling Non Administrator users" >>$global:LogFile
	try
	{
		"Asking User $user to log off ">> $global:LogFile
		$answer = read-host -Prompt "`nAll non-administrator users need to logoff before taking backup.Do you want to logoff $user? (Y/N)" 
		if ($answer -eq "Y")
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : Logging off " $user -ForegroundColor Green
			LOGOFF $session_Id
		}
		elseif ($answer -eq "N")
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] All non-administrator users need to logoff to proceed" -ForegroundColor Red
			write-host("`n")
			write-host "`n$time : FAILURE!!" -ForegroundColor Red
			EXIT (1)
		}
		else
		{
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] Invalid Input. `n" -ForegroundColor Red
			handle_NonAdmin_Users -user $user,  -session_Id $session_Id
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in handle_NonAdmin_Users function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}
