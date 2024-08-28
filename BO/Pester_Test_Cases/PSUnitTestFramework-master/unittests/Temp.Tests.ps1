$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "tocheckif_Admin" {
	It "check_If_Admin" {
		check_If_Admin | Should be "Logged is as Administrator"
   }
}

Describe "check_If_NonAdmin" {
	It "check_If_NonAdmin" {
		check_If_NonAdmin | Should Be 
		
	}
} 

Describe  "WindowsTaskStatus" {
	It "WindowsTaskStatus" {
		WindowsTaskStatus | Should Be 
    }
}

Describe "check_if_admin" {
	It "check_If_Admin" {
		check_If_Admin | Should Be "Logged is as Administrator"
    }
}