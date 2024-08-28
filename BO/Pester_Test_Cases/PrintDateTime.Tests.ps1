$TimeStamp = Get-Date -Format yyyy-MM-dd_HH_mm_ss
$PreLog = "C:\ebid\ebid_automation\log\ebid_prerequisite-$TimeStamp.log"

function PrintDateTime()
{    
    "----------------------------------------------- " >>$PreLog
    Get-Date -Format "dddd [MM/dd/yyyy] [HH:mm:ss]" >>$PreLog
    "----------------------------------------------- " >>$PreLog
}
Describe "PrintDateTime" {
	It "PrintDateTime" {
		PrintDateTime | Should Be 
		}
}

