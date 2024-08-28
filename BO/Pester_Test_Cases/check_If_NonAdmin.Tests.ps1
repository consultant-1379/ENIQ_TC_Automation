$global:Time_Stamp=get-date -format yyyy-MM-dd_HH_mm_ss
$global:LogFile = "C:\ebid\ebid_automation\log\ebid_automation_log-"+$global:Time_Stamp+".log"

Function PrintDateTime()
{    
    "----------------------------------------------- " >>$global:LogFile 
     Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$global:LogFile
    "----------------------------------------------- " >>$global:LogFile      
}

# **************************************************************************************
#	Check if there are any Non Administrator users Logged in 
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

Describe "check_If_NonAdmin" {
	It "check_If_NonAdmin" {
		check_If_NonAdmin | Should Be 
		
	}
} 