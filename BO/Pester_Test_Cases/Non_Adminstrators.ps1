Check if there are any Non Administrator users Logged in 
# **************************************************************************************

function check_If_NonAdmin
{
	PrintDateTime
	"`nChecking for other users" >>$global:LogFile
	try
	{
		$users = QUERY USER
		if($users.Length -gt 2)
		{
			"Non Administrator Users is/are logged in ">> $global:LogFile
			for ($i=1, $i -lt $users.Length, $i++)
			{
				$user = $users[$i].trim() -split ' {2,}'			
				if($user[0] -NotLike '*Administrator' )
				{
					handle_NonAdmin_Users -user $user[0], -session_Id $user[2]
				}
				else
				{
					return
				}
			}		
		}
		else
		{
			return
		}
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in check_If_NonAdmin function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}