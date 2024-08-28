unction to Backup LegalNotice.ini
# -----------------------------------------------------------------------------------

function Backup_LegalNoticeFiles()
{
	PrintDateTime
	$Path_LegalNotice = "C:\ebid\install_config\LegalNotice.ini"
	$Backup_LegalNotice = "C:\ebid\"

	$Check_Backup_LegalNotice = "C:\ebid\LegalNotice.ini"
	if (Test-Path -Path $Check_Backup_LegalNotice)
	{
		"'LegalNotice.ini' backup is present in $Backup_LegalNotice directory" >>$global:LogFile
	}
	else
	{
		"'LegalNotice.ini' backup is not present in $Backup_LegalNotice directory" >>$global:LogFile
		if (Test-Path -Path $Path_LegalNotice)
		{
			"'LegalNotice.ini' file is found in C:\ebid\install_config\ directory" >>$global:LogFile
			
			Copy-Item $Path_LegalNotice -Destination $Backup_LegalNotice -Force
			"Copied 'LegalNotice.ini' file to $Backup_LegalNotice directory" >>$global:LogFile
		}
		else
		{
			"$Path_LegalNotice is not present" >>$global:LogFile
		}
	}
}
