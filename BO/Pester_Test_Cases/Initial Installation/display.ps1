#*************************************************************************
# 	Ericsson Radio Systems AB                                     SCRIPT
# *************************************************************************
# 
#   	(c) Ericsson Radio Systems AB 2021 - All rights reserved.
#   	The copyright to the computer program(s) herein is the property
# 	and/or copied only with the written permission from Ericsson Radio
# 	Systems AB or in accordance with the terms and conditions stipulated
# 	in the agreement/contract under which the program(s) have been
# 	supplied.
#
# ********************************************************************
# 	Name    : UniverseReportPromotion.ps1
# 	Date    : 13/01/2021
# 	Revision: A.7
# 	Purpose : This powershell script is used to get the list of Universes and
#			  Reports from ENIQ server . 	
#
# 	Usage   : display.ps1
#
#
# ********************************************************************





# Function to take input of eniq server
Function Eniqloginserver{
	$global:Eniqserver = Read-Host "`nEnter FQDN of ENIQ Server"
	$global:Eniqserver = $global:Eniqserver.Trim()
	IF($global:Eniqserver -eq "" )
	{
		Write-Host "`n[ ERROR ] : value should not be Null. Please enter appropriate value." -ForegroundColor Red
		Eniqloginserver
	}
}

#function to take eniq username
Function EniqUserLogin{
	$global:EniqUsername = Read-Host "`nEnter Username of ENIQ Server"
	$global:EniqUsername = $global:EniqUsername.Trim()
	IF($global:EniqUsername -eq "" )
	{
		Write-Host "`n[ ERROR ] : value should not be Null. Please enter appropriate value." -ForegroundColor Red
		EniqUserLogin
	}
}

#function to take eniq password
Function Eniqdetails{
	$userInput= read-host -Prompt "`nEnter Password of ENIQ Server" -AsSecureString
            $bstrUserInput= [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($userInput)
            $global:NewEniqPassword= [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstrUserInput).trim()   
			#Write-Host($global:NewEniqPassword)
	IF($global:NewEniqPassword -eq "" )
	{
		Write-Host "`n[ ERROR ] : value should not be Null. Please enter appropriate value." -ForegroundColor Red
		Eniqdetails
	}
}

#Function to copy folders
Function copy_Folder($source_directory, $destination_Directory)
{
    try
    {
	    copy-item -path $source_directory -destination $destination_Directory -Recurse -Force
	    return 
    }
    catch
	{
		
		
		write-host "[ERROR]: Unable to copy the folder." -ForegroundColor Red
		Exit
	}
}

# ------------------------------------------------------------------------
#  Function to Mount Media
# ------------------------------------------------------------------------

Function MountMedia($Media)
{
	
	
	try
	{			
		if((Get-DiskImage -ImagePath $Media).Attached)
		{
			
			$DriveLetter = (Get-DiskImage -ImagePath $Media | Get-Volume).DriveLetter
			$DriveLetter = $DriveLetter + ":\"      
		}
		else
		{
			"Media: $Media Not mounted and mounting..." >>$global:LogFile
			$DriveLetter = (Mount-DiskImage -ImagePath $Media -PassThru | Get-Volume).DriveLetter        
			$DriveLetter = $DriveLetter + ":\"        
		}  
		
		return $DriveLetter
	}
	catch
	{
		
		write-host "[ERROR] : Exception in MountMedia function for $Media." -ForegroundColor Red
		Exit
	}
}


#check universe report promotion folder is present
function CheckUniveseReportfolder()
{
	$WindowsDriveLetter = MountMedia($global:EBIDMedia)	
	$destination_Directory = "C:\ebid\"
	$file_To_Be_Copied = ($WindowsDriveLetter + $global:Universe_Report_Path)	
	copy_Folder -source_Directory $file_To_Be_Copied -destination_Directory $destination_Directory
	if (test-path -Path "C:\ebid\universe_report_promotion")
	{
		Write-Host("`nCopied $file_To_Be_Copied to $destination_Directory directory.")
	}
	else
	{
		
		$time = get-date -Format "yyyy MM dd HH:mm:ss"
		write-host "[ERROR]: Couldn't copy $file_To_Be_Copied to $destination_Directory" -ForegroundColor Red
		Exit
	}
}



#Function for extracting the name of the universe
function ExtractNameUniv{
	Param ([String] $y)
	$Splitted = $y -split '_' 
	$index=$Splitted.Count-2
	For ($i=0; $i -lt $index; $i++) {
   		$NameUniv+=$Splitted[$i]
        	$NameUniv+='_'	
    	}
	return $NameUniv
} 
#Function for checking the latest version
function CheckMaxUniv{
	Param ([String] $m, [String] $s)
	$RstateMax=  ($m -split '_')[($m -split '_').count - 2]
	$BuildMax = ($m -split '_')[($m -split '_').count - 1]
	$RstateCompareTo= ($s -split '_')[($s -split '_').count - 2]
	$BuildCompareTo = ($s -split '_')[($s -split '_').count - 1]
	$RstateCompareToSub = $RstateCompareTo.Substring(1)
	$RstateMaxSub = $RstateMax.Substring(1)
	$RstateCompareToSub = [char[]]$RstateCompareToSub
	$RstateMaxSub = [char[]]$RstateMaxSub	
	foreach( $value in $RstateMaxSub ) {
		if ( ($value -ge 65) -and ($value -le 90)){
			$VersionMax = $value
			break;
		} 
	}
	foreach( $value in $RstateCompareToSub ) {
		if ( ($value -ge 65) -and ($value -le 90)){
			$VersionCompareTo = $value
			break;
		} 
	}
	$RstateMaxSub = [String]$RstateMaxSub
	$RstateCompareToSub = [String]$RstateCompareToSub
	#if ($VersionMax -gt $VersionCompareTo){
	#	$flag=1
	#}
	#ElseIf ( $VersionMax -eq $VersionCompareTo){		
		$LeftMax = $RstateMaxSub.Substring(0, $RstateMaxSub.IndexOf($VersionMax))		
		$LeftCompareTo = $RstateCompareToSub.Substring(0, $RstateCompareToSub.IndexOf($VersionCompareTo))
		$LeftMaxPadded=($LeftMax -replace " ", "").ToString().PadLeft(6, '0')
		$LeftCompareToPadded=($LeftCompareTo -replace " ", "").ToString().PadLeft(6, '0')
			If ($LeftMaxPadded -gt $LeftCompareToPadded) {
				$flag =1 
			}
			ElseIf ( $LeftMaxPadded -eq $LeftCompareToPadded ) {
				if ($VersionMax -gt $VersionCompareTo){
					$flag=1
				}
				ElseIf ($VersionMax -eq $VersionCompareTo) {
					$BuildCompareToSub = $BuildCompareTo.Substring(1)
					$BuildMaxSub = $BuildMax.Substring(1)
					$mBuildPadded=($BuildMaxSub -replace " ", "").ToString().PadLeft(6, '0')
					$sBuildPadded=($BuildCompareToSub -replace " ", "").ToString().PadLeft(6, '0')
					if ($mBuildPadded -ge $sBuildPadded){
						$flag = 1
					}
					else {
					$flag = 0
					}
				}
				Else {
				$flag = 0
				}
			}
		else {
			$flag=0
		}
	return $flag
}
#Function for displaying the latest version of Universe
function DisplayMaxUniv {
	Param ( [String[]] $ar)
	$TotalItems = @()
	foreach ($x in $ar){
		$TotalItems+= $x
    }
	$totalItemsCount = $ar.COUNT
	$UniverseWithLatestVersion = @()
	For ($r=0; $r -lt $totalItemsCount; $r++) {
		$ExtractedNameFirstLoop= ExtractNameUniv -y $ar[$r]
		$max =  $ar[$r]
		For ($s=0; $s -lt $totalItemsCount; $s++) {
			$ExtractedNameSecondLoop= ExtractNameUniv -y $ar[$s]
			if (($ExtractedNameFirstLoop -match $ExtractedNameSecondLoop) -and ($ar[$r] -ne $ar[$s])){	
				$bool = CheckMaxUniv -m $max -s $ar[$s]
				if ( $bool -eq 0 ) {
					$max = $ar[$s]
				}
			}			
		}
		$UniverseWithLatestVersion+=$max	
	}
	$UniverseWithLatestVersionUnique = $UniverseWithLatestVersion | select -uniq
	return $UniverseWithLatestVersionUnique
}
#------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------
#Function for extracting the name of the report
function ExtractName{
	Param ([String] $y)
	$Splitted = $y -split '_' 
	$index=$Splitted.Count-1
	For ($i=0; $i -lt $index; $i++) {
    		$Name+=$Splitted[$i]
         	$Name+='_'	
    	}
	return $Name
}
#Function for extracting the Rstate of the report
 function ExtractRstate{
	Param ([String] $d)
	$Splitted = $d -split '_' #($d -split '_')[$Splitted.Count-1]
	$index=$Splitted.Count-1
	$Rstate = $Splitted[$index]
	$Rstate = $Rstate.ToString().ToUpper()
	return $Rstate	
}  
#Function for checking the latest version for each iteration
function CheckMaximumReport{
	Param ([String] $m, [String] $s)
	$CompareTo = [char[]]$s
	$Max = [char[]]$m
	$flag= 0
	foreach( $value in $Max ) {
		if ( ($value -ge 65) -and ($value -le 90)){
			$VersionMax = $value
			break;
		} 
	}
	foreach( $value in $CompareTo ) {
		if ( ($value -ge 65) -and ($value -le 90)){
			$VersionCompareTo = $value
			break;
		} 
	}
	$Max = [String]$Max
	$CompareTo = [String]$CompareTo
	#if ($VersionMax -gt $VersionCompareTo){
	#	$flag=1
	#}
	#ElseIf ( $VersionMax -eq $VersionCompareTo){
		$PositionVersion = $Max.IndexOf($VersionMax)
		$LeftMax = $Max.Substring(0, $PositionVersion)
		$RightMax = $Max.Substring($PositionVersion+1)
		$PositionVersionCompareTo = $CompareTo.IndexOf($VersionCompareTo)
		$LeftCompareTo = $CompareTo.Substring(0, $PositionVersionCompareTo)
		$RightCompareTo = $CompareTo.Substring($PositionVersionCompareTo+1)
		$LeftMax = $LeftMax -replace " ", ""
		$LeftCompareTo = $LeftCompareTo -replace " ", ""
		$RightMax = $RightMax -replace " ", ""
		$RightCompareTo = $RightCompareTo -replace " ", ""
		$LeftMaxPadded=$LeftMax.ToString().PadLeft(6, '0')
		$LeftCompareToPadded=$LeftCompareTo.ToString().PadLeft(6, '0')
		$RightMax=$RightMax.trim().ToString().PadLeft(6, '0')
		$RightCompareTo=$RightCompareTo.trim().ToString().PadLeft(6, '0')
		if ( $LeftMaxPadded -gt $LeftCompareToPadded ) {
			$flag=1
		}
		ElseIf ( $LeftMaxPadded -eq $LeftCompareToPadded ) {
			if ($VersionMax -gt $VersionCompareTo){
				$flag=1
			}
			ElseIf ($VersionMax -eq $VersionCompareTo){
				if ( $RightMax -ge $RightCompareTo ){
					$flag=1
				}
				else {
					$flag=0
				}
			}			
			else {
				$flag=0
			}
		}	
		else {
			$flag=0
		}
		return $flag
}
#Function to display Latest version for Reports
function DisplayMax {
	Param ( [String[]] $ar)
	$TotalItems = @()
	foreach ($x in $ar){
		$TotalItems+= $x
    }
	$TotalItemsCount = $TotalItems.COUNT
	$ReportsWithLatestVersion = @()
	For ($r=0; $r -lt $TotalItemsCount; $r++) {
		$ExtractedNameFirstLoop= ExtractName -y $TotalItems[$r]
		$ExtractedRstateFirstLoop= ExtractRstate -d $TotalItems[$r]
		$max =  $ExtractedRstateFirstLoop.Substring(1)
		For ($s=0; $s -lt $TotalItemsCount; $s++) {
			$ExtractedNameSecondLoop= ExtractName -y $TotalItems[$s]
			$ExtractedRstateSecondLoop= ExtractRstate -d $TotalItems[$s]
			if (($ExtractedNameFirstLoop -match $ExtractedNameSecondLoop) -and ($TotalItems[$r] -ne $TotalItems[$s])){					
				$CompareWith =  $ExtractedRstateSecondLoop.Substring(1)
				$bool = CheckMaximumReport -m $max -s $CompareWith
				if ( $bool -ne 1 ) {
					$max = $CompareWith
				}
			}
		}
		$TempReportsWithLatestVersion=$ExtractedNameFirstLoop, $max -join "R"
		$ReportsWithLatestVersion+=$TempReportsWithLatestVersion					
	}
	$ReportsWithLatestVersionUnique = $ReportsWithLatestVersion | select -uniq
	return $ReportsWithLatestVersionUnique
}
#------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------
# Function for displaying labels
Function DisplayLabel($text) {
	$label = New-Object System.Windows.Forms.Label
	$label.Text = $text
	$label.Location = New-Object System.Drawing.Size($left_margin,$top_margin) 
	$label.Size = New-Object System.Drawing.Size(280,20)
	$label.Font = "Tahoma,$font_size,style=$font_style"
	$label.AutoSize = $true
	$label.ForeColor = $font_color
	$obj_form.Controls.Add($label)
}
# Function for list directories of ENIQ server
Function Listdirectory($directory) {
	$script:not_valid = 0
	If ( $server_name -eq "" ) { $script:not_valid = 1 }
	If ( $user_name -eq "" ) { $script:not_valid = 1 }
	If ( $password -eq "" ) { $script:not_valid = 1 }
	If ( $port -eq "" ) { $script:not_valid = 1 }
	
	try {
		Add-Type -Path "C:\ebid\universe_report_promotion\WinSCPnet.dll"
		# Setup session options
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
			$directories = $session.Listdirectory($directory)
			$dir_listing_all = $directories.Files.Name
			$script:dir_listing = $dir_listing_all | Where-Object { ($_ -ne ".") -and ($_ -ne "..") }
		}
		finally {
           
			$session.Dispose()
		}
	}
	catch [Exception] {
		$error_msg = "`"Error: {0}`" -f $_.Exception.Message" 
		$error_msg >> $log	
	}
	If ($error_msg){
			$script:not_valid = 1
			$error_msg = $NULL
	}	
}

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

# Function for creating properties file for each lcmbiar
Function CreatePropertiesFile {
	New-Item "C:\ebid\universe_report_promotion\lcmbiar.properties" -type file -force
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nexportDependencies=true"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`naction=promote"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nDestination_CMS=$bis_name"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nLCM_userName=$bis_user"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nLCM_password=$bis_password"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nLCM_CMS=$bis_name"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nDestination_authentication=secEnterprise"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nDestination_userName=$bis_user"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nlcmbiarpassword="
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nDestination_password=$bis_password"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nLCM_authentication=secEnterprise"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nimportLocation=$target"
	Add-Content "C:\ebid\universe_report_promotion\lcmbiar.properties" "`nconsolelog=true"
}
# Function for promoting lcmbiars
Function PromoteLcmbiar {

	CreatePropertiesFile
	$properties_file_exists = Test-Path "C:\ebid\universe_report_promotion\lcmbiar.properties"
	#$properties_file_exists = Test-Path "C:\ebid\universe_report_promotion\"
    If ($properties_file_exists){
		$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
		
		"`n$datetime Properties file is created for $file." >> $log
		$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
		
		"`n$datetime Promoting $file.." >> $log
		# Promote lcmbiars using lcm_cli.bat
		$lcm_cli_result = cmd.exe /c "$bi_install_dir`SAP BusinessObjects Enterprise XI 4.0\win64_x64\scripts\lcm_cli.bat" -lcmproperty "C:\ebid\universe_report_promotion\lcmbiar.properties" 
		$lcm_cli_result >> $log
		# Check if promotion is successful
		$promotion_success_41 = $lcm_cli_result | Select-String "Job Status : Success"
		$promotion_partial_success_41 = $lcm_cli_result | Select-String "Job Status : Partial Success"
		$promotion_success_42 = $lcm_cli_result | Select-String "Job Status  : Success"
		$promotion_partial_success_42 = $lcm_cli_result | Select-String "Job Status  : Partial Success"
		If (($promotion_success_41 -ne $null) -or ($promotion_success_42 -ne $null)) {
			$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
			$global:Statuscount+=1
		} ElseIf (($promotion_partial_success_41 -ne $null) -or ($promotion_partial_success_42 -ne $null)) {
			$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
			
		} Else {
		$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
			
			$script:error_count = $script:error_count + 1
		}
	} Else {
		$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"

		"`n$datetime Properties file could not be created for $file." >> $log
	}
	Write-Host($global:Statuscount)
	$file_exists = Test-path "C:\ebid\universe_report_promotion\lcmbiar.properties"
	If ($file_exists -eq "True"){
		Remove-Item "C:\ebid\universe_report_promotion\lcmbiar.properties"
	}
	"==============================================================================" >> $log
	
}

# Function to convert unix files to windows

Function UnixToWindowsConversion {
	$scriptBlockConversionCmd = {
        Get-ChildItem C:\ebid\universe_report_promotion\reports.txt | ForEach-Object { 
			$contents = [IO.File]::ReadAllText($_) -replace "`n", "`r`n"
			$utf8 = New-Object System.Text.UTF8Encoding $false
			[IO.File]::WriteAllText($_, $contents, $utf8)
		}
    }
    try {
       Invoke-Command -ScriptBlock $scriptBlockConversionCmd -errorAction stop 
    } catch {
		$errorMessage = $_.Exception.Message
    }
}

Function FVMPromote {
	$script:source = "/eniq/sw/installer/fvm_boreports/ERBS/reports.txt"
	$script:target = "C:\ebid\universe_report_promotion\"
	$bis_user = $args[0]
	$bis_password = $args[1]
	$bis_name = $args[2]
	$script:server_name = $args[3]
	$script:user_name = $args[4]
	$script:Password = $args[5]
	$script:port = $args[6]
	DownloadFromENIQ
	UnixToWindowsConversion
	foreach($line in Get-Content C:\ebid\universe_report_promotion\reports.txt) {
		Write-host $line
        $directory = "/eniq/sw/installer/boreports/" + $line + "/"
		Write-Host $directory
		Listdirectory($directory)
		foreach ($file in ( $dir_listing | Where {$_ -like "*lcmbiar"})){
			$source = "/eniq/sw/installer/boreports/" + $line + "/" + $file
			$script:target = "C:\ebid\universe_report_promotion\" + $file
			DownloadFromENIQ
			CreatePropertiesFile
			cmd.exe /c "$bi_install_dir`SAP BusinessObjects Enterprise XI 4.0\win64_x64\scripts\lcm_cli.bat" -lcmproperty "C:\ebid\universe_report_promotion\lcmbiar.properties"  >>$log
			#remove-item "C:\ebid\universe_report_promotion\lcmbiar.properties"
			remove-item $target
		}	
	}
	remove-item C:\ebid\universe_report_promotion\reports.txt
}

		
	
# Function for creating the second page
Function CreateFormSecondPage {
	# Create the form
	    CheckUniveseReportfolder
	    Write-Host("")
		#Write-Host "Enter the eniq server details where universe and report packages are present."
	    #calling function to take eniq server input
	        Eniqloginserver
		    EniqUserLogin
		    Eniqdetails
	
						  
	
	

		
	
	[string]$Eniq_hostname=$global:Eniqserver
	[string]$Eniq_Username= $global:EniqUsername
	$passwordValue = $global:NewEniqPassword
	
	
	
	
	$server_name_with_port = $Eniq_hostname
				If	(!($server_name_with_port.contains(":"))){			
					$script:server_name=$server_name_with_port
					$script:port = 22
				} Else {					
					$server_name_without_port,$server_port = $server_name_with_port | foreach split :
					$script:server_name = $server_name_without_port				
						If(($server_port.count) -ge 2){
							$not_valid = 1						
						}	Else {
								 $script:port = $server_port	
								 }
						}
			$script:user_name=$Eniq_Username
			$script:password=$passwordValue
			Listdirectory("/eniq/sw/installer/bouniverses/")
			If ($not_valid -eq 1){
				Write-Host("`n$datetime Error! Incorrect details provided. Unable to log in to the $server_name server.") -ForegroundColor Red 
				$global:EniqLogin+=1
				if($global:EniqLogin -eq 3){
				Exit
				}
				CreateFormSecondPage
                		
				
			} Else {
				Write-Host("")
				Write-Host("Login Success")-ForegroundColor Green
				
				
				$script:promote_univ = 0
				If ($null -eq $dir_listing){
				
					Write-Host("No universe packages available in the server")
					$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
					
				$global:Availableuniv=1
				}
				Else {
					$script:promote_univ = 1
					# List universes in a listbox
					$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
					
					
					$arr_pass_Univ = [String[]]$script:dir_listing
					$arrStartWithBO = @()
					foreach ($temp in $arr_pass_Univ) {
						if($temp.StartsWith("BO")){
							$arrStartWithBO += $temp
						}
					}	
				}
					
					$latest_universe = @()
					$script:dir_listing = DisplayMaxUniv -ar $arrStartWithBO
					Foreach ($directory in $dir_listing) {
						$latest_universe +=$directory
					}
					
					#reports presentin eniq server or not
					Listdirectory("/eniq/sw/installer/boreports/")
				#Write-Host("Available Report Packages:")
				$script:promote_rep = 0
				# Check if any report is present
				If ($null -eq $dir_listing){
					
					$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
					
				 Write-Host("No report packages available in the server")
				 $global:Availablerep=1
				} Else {
					$script:promote_rep = 1
					# List reports in a listbox
					$datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
					
					
				  $arr_pass = [String[]]$script:dir_listing
				  
					$ArrwithReport = @()
					foreach ($temp in $arr_pass) {
						if ( $temp -match "Report" ) {
							$ArrwithReport += $temp
						}
					}
					$latest_report = @()
                    $script:dir_listing = DisplayMax -ar $ArrwithReport 
					Foreach ($directory in $dir_listing) {
						$latest_report += $directory
						
					}
				}
				$file_display = Test-path "C:\ebid\ebid_automation\display.txt"		
									If ($file_display -eq "True"){
										rm "C:\ebid\ebid_automation\display.txt" -Recurse -Force
									}
				 New-Item C:\ebid\ebid_automation\display.txt
				Add-Content 'C:\ebid\ebid_automation\display.txt'  "Available Universes"
					$j=1		
				Foreach ($i in $latest_universe) {
					
						Add-Content 'C:\ebid\ebid_automation\display.txt'  "$j- $i"
						$j=$j+1 
						
				}
					Add-Content 'C:\ebid\ebid_automation\display.txt'  " "
					Add-Content 'C:\ebid\ebid_automation\display.txt'  "Available Reports "
					$k=1
					Foreach ($i in $latest_report) {
						Add-Content 'C:\ebid\ebid_automation\display.txt'  "$k- $i"
						$k=$k+1
						
					}
					Write-Host("")
					Write-Host("List of universe and report packages are saved in C:\ebid\ebid_automation\display.txt file.")-ForegroundColor Green
				
				
			}
}
	
			
	
	


# Main  
$global:Universe_Report_Path = "universe_report_promotion"
$global:EBIDMedia = "C:\ebid\ebid_medias\Ericsson_Business_Intelligence_Deployment_Automation_Package_Media.iso"

$script:datetime = Get-Date -format "[yyyy-MM-dd HH:mm:ss]"
$time_stamp=Get-Date -format yyyy-MM-dd_HH_mm_ss

$script:font_color = "black"
$script:font_size = 10
If ($($args.Count) -eq 0) {
 CreateFormSecondPage
} Else {
	FVMPromote
	$clientIP = "10.45.197.247"
	$Username = "athtem3\administrator"
	$Password = "Shroot12"
	$pass = ConvertTo-SecureString -AsPlainText $Password -Force
	$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
	$Cred >>$log
	$clientIP >>$log
	Set-Item WSMan:\localhost\Client\TrustedHosts -Value $clientIP -Force
	Invoke-Command -ComputerName $clientIP -ScriptBlock { New-Item C:\ebid\blahblah1.txt -ItemType file } -credential $Cred >>$log
}



