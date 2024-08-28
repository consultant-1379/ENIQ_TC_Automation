$EbidAutomationLoginTaskName  = "EBIDUpgradeProgress"
$LogFileLoginTask = "C:\ebid\ebid_automation\log\ebid_automation_logintask.log"

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

Describe "DeleteTaskfromTaskScheduler" {
	It "DeleteTaskfromTaskScheduler" {
		DeleteTaskfromTaskScheduler | Should Be 
    }
}
