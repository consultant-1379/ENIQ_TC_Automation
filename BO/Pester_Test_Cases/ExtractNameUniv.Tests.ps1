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
Describe "ExtractNameUniv" {
	It "ExtractNameUniv" {
		ExtractNameUniv | Should Be
    }
}