echo "HOSTNAME"
hostname
cd C:\NetAn_features\
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f 'esjkadm100',$env:pass)))
$features = 'featureName'
$MyUser = "esjkadm100"
$MyPass = "Naples!0512"
Foreach ($Module in $features){
	Write-Host "Downloading $Module"
  	[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
	Invoke-WebRequest -Uri https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/service/local/repositories/assure-releases/content/com/ericsson/eniq/netanserver/features/$Module/maven-metadata.xml -UseBasicParsing -Headers @{ Authorization = "Basic "+ [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($("esjkadm100:Naples!0512"))) } -O data.txt
    $rs = cat data.txt | Select-String 'release'
	$rs = $rs.toString()
	$rs = $rs.trim()
	$ret = [Regex]::Matches($rs, "\>(.*?)\<")
	$Rstate = $ret[0].Groups[1].Value
    if ($Module -like 'network-analytics-pm-alarming'){
      	$rs = cat data.txt | Select-String 'R8A'
      	$ret = [Regex]::Matches($rs, "\>(.*?)\<")
		$Rstate = $ret[$ret.Count-1].Groups[1].Value
	}
  	if ($Module -like 'network-analytics-pm-data'){
      	$rs = cat data.txt | Select-String 'R5A'
      	$ret = [Regex]::Matches($rs, "\>(.*?)\<")
		$Rstate = $ret[$ret.Count-1].Groups[1].Value
	}
  	if ($Module -like 'network-analytics-pm-explorer'){
      	$rs = cat data.txt | Select-String 'R7A'
      	$ret = [Regex]::Matches($rs, "\>(.*?)\<")
		$Rstate = $ret[$ret.Count-1].Groups[1].Value
	}
	Write-Host $Rstate
	Write-Host "Invoke-RestMethod -Uri https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/service/local/repositories/assure-releases/content/com/ericsson/eniq/netanserver/features/$Module/$Rstate/$Module-$Rstate.zip -outfile $Module-$Rstate.zip"
	Invoke-WebRequest -Uri https://arm1s11-eiffel013.eiffel.gic.ericsson.se:8443/nexus/service/local/repositories/assure-releases/content/com/ericsson/eniq/netanserver/features/$Module/$Rstate/$Module-$Rstate.zip -Headers @{ Authorization = "Basic "+ [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($("esjkadm100:Naples!0512"))) } -outfile $Module-$Rstate.zip
	if ($Module -like "*pm-data*"){
        cp network-analytics-pm-data-$Rstate.zip C:\Ericsson\tmp\
        Remove-Item C:\Ericsson\tmp\pmdata -Recurse -Force -ErrorAction SilentlyContinue
        Unzip-File C:\Ericsson\tmp\network-analytics-pm-data-$Rstate.zip C:\Ericsson\tmp\pmdata
        Write-Host "C:\Ericsson\tmp\pmdata\resources\Pre-Installation.ps1 upgrade"
        C:\Ericsson\tmp\pmdata\resources\Pre-Installation.ps1 upgrade
        Remove-Item C:\Ericsson\tmp\network-analytics-pm-data-$Rstate.zip -Recurse -Force -ErrorAction SilentlyContinue
      	#Expand-Archive -Force network-analytics-pm-data-$Rstate.zip
		Install-Feature -Force C:\Ericsson\tmp\pmdata\feature.zip
	}
	elseif ($Module -like "*Consistency-Check*"){
      	cp featureName-$Rstate.zip C:\Ericsson\tmp\
  		Remove-Item C:\Ericsson\tmp\cmconsistencycheck -Recurse -Force -ErrorAction SilentlyContinue
  		Unzip-File C:\Ericsson\tmp\featureName-$Rstate.zip C:\Ericsson\tmp\cmconsistencycheck
  		Write-Host "C:\Ericsson\tmp\cmconsistencycheck\resources\Pre-Installation.ps1 install"
  		Remove-Item C:\Ericsson\tmp\featureName-$Rstate.zip -Recurse -Force -ErrorAction SilentlyContinue
  		Install-Feature -Force C:\Ericsson\tmp\cmconsistencycheck\feature.zip
    }
	else{
        
		Install-Feature -Force $Module-$Rstate.zip
	}
}