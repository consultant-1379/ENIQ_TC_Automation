$EbidAutomationTaskName = "EBIDAutomation"
$LogFileLoginTask = "C:\ebid\ebid_automation\log\ebid_automation_logintask.log"

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

Describe  WindowsTaskStatus{
	It "WindowsTaskStatus" {
		WindowsTaskStatus | Should Be 
    }
}