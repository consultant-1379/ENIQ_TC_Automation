
function CheckServersHealth()
{
	$CCMDirectory=$bi_install_dir+"SAP BusinessObjects Enterprise XI 4.0\win64_x64\ccm.exe"
	$obj = & $CCMDirectory -display  all -username Administrator -password $cmsPassword
	$obj >>$LogFiles

	if($obj -like "*Unable*")
				{
					"Unable to login to SIA and checking again" >>$LogFiles
					"Unable to login to SIA and checking again" >>$LogFiles
				}

	else{
	$running=0
	$enabled=0

	foreach ($line in $obj){
		   if (Select-String -InputObject $line -Pattern "Server Name" -AllMatches) {
			   $Server_Name=$line
			   $Server_Name = "$Server_Name".split(" ")
			   $Server_Name = $Server_Name[0]	   
			   #Write-host($Server_Name)	   
		   }
		   
		   if (Select-String -InputObject $line -Pattern "State:" -AllMatches) {
			   $Server_State=$line
			   $Server_State = "$Server_State".split(" ")
			   $Server_State = $Server_State[0].trim()
			   if ($Server_State -eq "Running")
			   {
				$running=$running+1  
			   }		   
			   #Write-host ($Server_State)
		   }
		  
			if ((Select-String -InputObject $line -Pattern "Enabled:" -AllMatches) -Or (Select-String -InputObject $line -Pattern "Disabled:" -AllMatches)) {
				$Server_Enabled_Disabled=$line
				$Server_Enabled_Disabled = "$Server_Enabled_Disabled".split(" ")
				$Server_Enabled_Disabled = $Server_Enabled_Disabled[0].trim()
				if ($Server_Enabled_Disabled -eq "Enabled")
			   {
				$enabled=$enabled+1  
			   }	
				#Write-host ($Server_Enabled_Disabled)
			}
	}
	"The count of running servers out of 20: $running"  >>$LogFiles
	"The count of enabled servers out of 20: $enabled"  >>$LogFiles

	if (($running -eq 20) -AND ($enabled -eq 20))
	{
		"All servers are running and enabled." >>$LogFiles
	}  
	else{
		"Some servers are not running or enabled." >>$LogFiles
	}
	}
}

function DecryptingConfigurationFile()
{   
    #PrintDateTime        
    $house_keeping_config_file= "C:\ebid\housekeeping\ebid_housekeeping.ini"
    #Check if house_keeping_config file is present
    $house_keeping_config_files = Test-Path $house_keeping_config_file
    If ($house_keeping_config_files -ne "True") {
    	"House keeping configuration file is missing" >>$LogFiles
    	Exit
    } 
    $flag = 0
    foreach($line in Get-Content $house_keeping_config_file) 
    {
        If($line -match "cmspassword=")
        {
            $flag++
        }
    }
    if(Test-Path $keyFilePath)
    { 
        if($flag -eq 0)
        {
                 "Key file and ebid_encryption_decryption.ps1 exists, hence decrypting the configuration file" >>$LogFiles
                powershell -command ". C:\ebid\install_config\ebid_encryption_decryption.ps1; DecryptEBIDFile -path "C:\ebid\housekeeping\ebid_housekeeping.ini" -output 'C:\ebid\housekeeping\tmp.txt' -type 'housekeeping' ;"
                $house_keeping_config_file = "C:\ebid\housekeeping\tmp.txt"
            
        }
        else
        {
            "ebid_housekeeping.ini file is in decrypted format and key file present, so deleting the key file and continuing...." >>$LogFiles
            Remove-Item -Path $keyFilePath
        }
    }
    else
    {
        if($flag -ne 0)
        {
            "Key file doesn't exists and trying to fetch inputs from C:\ebid\housekeeping\ebid_housekeeping.ini file" >>$LogFiles            
        }    
        else
        {
            "ebid_housekeeping.ini file is in encrypted format but key doesn't exist." >>$LogFiles
            "Delete existing housekeeping folder and copy EBID_AUTOMATION_PACKAGE\housekeeping folder to C:\ebid folder" >>$LogFiles
            Exit
        }
    }       
    ReadingInputs	
}

function ReadingInputs()
{    
    foreach($line in Get-Content $house_keeping_config_file) 
    {
	    If($line -match "cmspassword="){
	    	$line_split = "$line".split("=",2)
	    	$cmspassword = $line_split[1].Trim()
            NullCheck $cmspassword "cmspassword"
	    }    
    }    
    CheckServersHealth
    EncryptingConfigurationFile
}

function EncryptingConfigurationFile()
{        
    #PrintDateTime
    if(!(Test-Path C:\ebid\housekeeping\tmp.txt))
    {
        if(!(Test-Path C:\ebid\install_config\ebid_encryption_decryption.ps1))
        {
            "Encryption decryption file doesn't exist in  C:\ebid\install_config\ path so cannot encrypt the configuration file and housekeeping activity stopped" >>$LogFiles 
            Exit      
        }
        else
        {
            "Temp file        : doesn't exist and encryption exists hence generating the key file" >>$LogFiles
            powershell -command ". C:\ebid\install_config\ebid_encryption_decryption.ps1; EncryptEBIDFile -filepath "C:\ebid\housekeeping\ebid_housekeeping.ini" -type "housekeeping" ; "
        }        
    }    
    else
    {
        "Temp file        : exist deleting the file" >>$LogFiles
        Remove-Item C:\ebid\housekeeping\tmp.txt
    }
	RestictAccess
}

function NullCheck($arg1, $arg2)
{
    if($arg1 -eq "")
    {
            "`n$arg2 : value is missing in configuration file(C:\ebid\housekeeping\ebid_housekeeping.ini)" >>$LogFiles
            Exit
    }
}

function RestictAccess()
{
$file ="C:\ebid\housekeeping\Key.txt"
		$config_file_exists=Test-Path $file
		If ($config_file_exists -eq "True") {
			Try { 
				$err = 0
				$acl = Get-Acl $file
				$isAccesRestricted = $false
				if(($acl.Access.FileSystemRights[0] -eq ("FullControl")) -and ($acl.Access.AccessControlType[0] -eq ("Allow")) -and ($acl.Access.IdentityReference[0].Value -eq ("BUILTIN\Administrators")) -and ($acl.Access.IsInherited[0] -eq $False) -and ($acl.Access.InheritanceFlags[0] -eq ("None")) -and ($acl.Access.PropagationFlags[0] -eq ("None")))
				{					
					$isAccesRestricted = $true
				} Else {
				If ($acl.AreAccessRulesProtected) { 
					$acl.Access | % {$acl.purgeaccessrules($_.IdentityReference)} 
				} Else {
					$isProtected = $true 
					$preserveInheritance = $false
					$acl.SetAccessRuleProtection($isProtected, $preserveInheritance) 
				}
				$rights=[System.Security.AccessControl.FileSystemRights]::FullControl
				$inheritance=[System.Security.AccessControl.InheritanceFlags]::None
				$propagation=[System.Security.AccessControl.PropagationFlags]::None
				$allowdeny=[System.Security.AccessControl.AccessControlType]::Allow
				$dirACE=New-Object System.Security.AccessControl.FileSystemAccessRule ("Administrators",$rights,$inheritance,$propagation,$allowdeny)
				$acl.AddAccessRule($dirACE) >>$LogFiles
				Set-Acl -aclobject $acl -path $file >>$LogFiles
				}
			} Catch {
				$ErrorMessage = $_.Exception.Message
				$ErrorMessage >>$LogFiles
				$err = 1
			} Finally {
				if(!$isAccesRestricted)
				{
				If ($err -eq 0) {
					"Restricting Access successful for $file" >>$LogFiles			
				} Else {
					"Restricting Access Failed for $file" >>$LogFiles	
				}
				} Else {
				 "$file is already access restricted" >>$LogFiles
				}
			}
		}		
}

#Main Function
$LogFiles = New-Item C:\ebid\server_health_check.log -ItemType File -Force
$bi_install_dir=(Get-ItemProperty -Path 'HKLM:\SOFTWARE\SAP BusinessObjects\Suite XI 4.0\config Manager' -Name InstallDir -ErrorAction SilentlyContinue).InstallDir
$keyFilePath='C:\ebid\housekeeping\key.txt'
DecryptingConfigurationFile