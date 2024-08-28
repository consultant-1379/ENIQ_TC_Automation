$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"



Describe "Testing check_if_admin" {
	It "checkifadmin" {
		check_If_Admin | Should Be "Logged is as Administrator"
    }
}

Describe "CheckIfBIInstalled" {
	It "Checking whether BI software is installed in the system or not" {
		CheckIfBIInstalled | Should Be
    }
}


Describe "CheckBIVersion" {
	It "Checking the BI software version installed in the system" {
		CheckBIVersion | Should Be
    }
}