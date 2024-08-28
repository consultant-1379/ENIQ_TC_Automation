Function to check if instllation configurations files are present
# -----------------------------------------------------------------------------------

Function CheckingConfigFile()
{ 
	PrintDateTime
	"Determining install ini file path"  >>$global:LogFile
	try
	{		
		$global:InstallConfigFile42Sp6 = "C:\ebid\install\ebid_bi42_sp6_p4_server.ini"
		$global:InstallConfigFile42Sp7 = "C:\ebid\install\ebid_bi42_sp7_p5_server.ini"        
		$global:InstallConfigFile42Sp8 = "C:\ebid\install\ebid_bi42_sp8_server.ini"
		$global:InstallConfigFile42Sp8P7 = "C:\ebid\install\ebid_bi42_sp8_p7_server.ini"
		$global:InstallConfigFile42Sp9P3 = "C:\ebid\install\ebid_bi42_sp9_p3_server.ini"
		$global:InstallConfigFile43Sp1P9 = "C:\ebid\install\ebid_bi43_sp1_p9_server.ini"
		$global:InstallConfigFile43Sp2 = "C:\ebid\install\ebid_bi43_sp2_server.ini"
		$global:InstallConfigFile43Sp2P4 = "C:\ebid\install\ebid_bi43_sp2_p4_server.ini"
		$global:InstallConfigFile43Sp3 = "C:\ebid\install\ebid_bi43_sp3_server.ini"	
	
		if(Test-Path $InstallConfigFile43Sp3)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp3
		}
		elseif(Test-Path $InstallConfigFile43Sp2P4)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp2P4
		}
		elseif(Test-Path $InstallConfigFile43Sp2)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp2
		}
		elseif(Test-Path $InstallConfigFile43Sp1P9)
		{
			$global:InstallConfigFile = $InstallConfigFile43Sp1P9
		}															  
		elseif(Test-Path $InstallConfigFile42Sp9P3)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp9P3
		}
		elseif(Test-Path $InstallConfigFile42Sp8P7)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp8P7
		}
		elseif(Test-Path $InstallConfigFile42Sp8)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp8
		}
		elseif(Test-Path $InstallConfigFile42Sp7)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp7
		}
		elseif(Test-Path $InstallConfigFile42Sp6)
		{
			$global:InstallConfigFile = $InstallConfigFile42Sp6
		}	
		else
		{
			"The installation configuration file is missing from C:\ebid\install\ directory." >>$global:LogFile
			$time = get-date -Format "yyyy MM dd HH:mm:ss"
			write-host "`n$time : [ERROR] The installation configuration file is missing from C:\ebid\install\ directory." -ForegroundColor Red
			EXIT
		}		
	}
	catch
	{
		$_ >>$global:LogFile
		"`nException in CheckingConfigFile function" >>$global:LogFile
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "`n$time : [ERROR] Check $global:LogFile for more details." -ForegroundColor Red
		Exit
	}
}

