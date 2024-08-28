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

Describe "DisplayMaxUniv" {
	It "DisplayMaxUniv" {
		 DisplayMaxUniv | Should Be
    }
}