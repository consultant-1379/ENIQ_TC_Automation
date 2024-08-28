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

Describe "ExtractName" {
	It "ExtractName" {
		ExtractName | Should Be 
	
	}
}