
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
."$here\$sut"

Describe "DeleteTaskfromTaskScheduler" {
	It "DeleteTaskfromTaskScheduler" {
		DeleteTaskfromTaskScheduler | Should Be 
    }
}

Describe "Testing check_if_admin" {
	It "check_if_admin" {
		check_If_Admin | Should Be "Logged is as Administrator"
    }
}

Describe "DownloadFromENIQ" {
	It "DownloadFromENIQ" {
		DownloadFromENIQ | Should Be
    }
}

