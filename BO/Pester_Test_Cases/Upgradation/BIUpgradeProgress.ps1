function Get-LogColor 
{
    Param([Parameter(Position=0)]
    [String]$LogEntry)

    process 
	{
        if ($LogEntry.Contains("Successful")) {Return "Green"}
        elseif ($LogEntry.Contains("Failed")) {Return "Red"}
		elseif ($LogEntry.Contains("Completed")) {Return "Green"}
        else {Return "White"}
    }
}

# ------------------------------------------------------------------------
#  Function to Delete Task from TaskScheduler.. 
# ------------------------------------------------------------------------

Function DeleteTaskfromTaskScheduler()
{       
    $time = get-date -Format "yyyy MM dd HH:mm:ss"
	"`n$time : Deleting Task from Task Scheduler  " >>$LogFileLoginTask
	try
	{
		$schedule = new-object -com("Schedule.Service")
        $schedule.connect()
        $tasks = $schedule.getfolder("\").gettasks(0)
        foreach ($t in $tasks)
		{
            $taskName=$t.Name
			if(($taskName -eq $EbidAutomationLoginTaskName))
			{
				"`n$time : Login Task exist, hence deleting it." >> $LogFileLoginTask
				schtasks /delete /tn $EbidAutomationLoginTaskName /f >> $LogFileLoginTask
            }
        }			
	}
	catch
	{
		$_ >>$LogFileLoginTask
		"`n$time : Exception in DeleteTaskfromTaskScheduler function" >>$LogFileLoginTask
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $LogFileLoginTask for more details."
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to get the status of EBID Automation task  
# ------------------------------------------------------------------------

Function WindowsTaskStatus()
{
$Taskfound = $false
$schedule = new-object -com("Schedule.Service")
$schedule.connect()
$tasks = $schedule.getfolder("\").gettasks(0)
$EbidAutomationTaskName = "EBIDAutomation"
	foreach ($t in $tasks)
	{
		$taskName=$t.Name
		if($taskName -eq $EbidAutomationTaskName)
		{
			$Taskfound = $true
			$taskStatus = (schtasks.exe /query /tn "EBIDAutomation" /s $env:computername  /v /fo CSV | ConvertFrom-Csv | Select-Object).status
			"$EbidAutomationTaskName found after reboot and the status of the task is: $taskStatus" >>$LogFileLoginTask
		}
	}
}

Start-Sleep -seconds 60
$Logfile = "C:\ebid\ebid_automation\log\ebid_automation_summary.log"
$LogFileLoginTask = "C:\ebid\ebid_automation\log\ebid_automation_logintask.log"
$EbidAutomationLoginTaskName  = "EBIDUpgradeProgress"
$user = [Security.Principal.WindowsIdentity]::GetCurrent();
$CheckUser  = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
$CurrentUser2 = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$WindowsPrincipal2 = New-Object System.Security.Principal.WindowsPrincipal($CurrentUser2)
if($CheckUser)
{
	"`n Logged on user is Administrator" >> $LogFileLoginTask
	if(test-path $Logfile)
	{
		"`n File exists" >> $LogFileLoginTask
	}
	else
	{
		Start-Sleep -seconds 60
	}
	WindowsTaskStatus
	DeleteTaskfromTaskScheduler
	gc -wait $LogFile | ForEach {Write-Host -ForegroundColor (Get-LogColor $_) $_}
}
elseif($WindowsPrincipal2.IsInRole("Domain Admins"))
{
	 "`n Logged on user is Domain Administrator" >> $LogFileLoginTask
	if(test-path $Logfile)
	{
		"`n File exists" >> $LogFileLoginTask
	}
	else
	{
		Start-Sleep -seconds 60
	}
	WindowsTaskStatus
	DeleteTaskfromTaskScheduler
	gc -wait $LogFile | ForEach {Write-Host -ForegroundColor (Get-LogColor $_) $_}
}
else
{   
    "`n Logged in user is neither Administrator nor Domain Administrator. Hence exiting from script" >> $LogFileLoginTask
    exit
}