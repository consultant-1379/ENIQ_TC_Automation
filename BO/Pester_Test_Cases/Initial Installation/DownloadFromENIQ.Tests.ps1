# Function for downloading lcmbiar files from ENIQ server
Function DownloadFromENIQ {
	try {
		Add-Type -Path "C:\ebid\universe_report_promotion\WinSCPnet.dll"
		$session_options = New-Object WinSCP.SessionOptions -Property @{
			Protocol = [WinSCP.Protocol]::Sftp
			HostName = "$server_name"
			UserName = "$user_name"
			Password = "$password"
			PortNumber = "$port"
			}
		$session_options.GiveUpSecurityAndAcceptAnySshHostKey = $true
		$session = New-Object WinSCP.Session
		try {
			$session.Open($session_options)
			$transferOptions = New-Object WinSCP.TransferOptions
			$transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
			$transferResult = $session.GetFiles("/$source", $target, $False, $transferOptions)
			$transferResult.Check()
			foreach ($transfer in $transferResult.Transfers){
				"Download of {0} succeeded" >> $log
			}
		}
		finally {
			$session.Dispose()
		}
	}
	catch [Exception] {
		"`"Error: {0}`" -f $_.Exception.Message" >> $log
	}
}

Describe "DownloadFromENIQ" {
	It "DownloadFromENIQ" {
		DownloadFromENIQ | Should Be ""
    }
