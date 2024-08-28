$file_path=$args[0]
$result_path=$args[1]
foreach($line in [System.IO.File]::ReadLines($file_path))
{
       Write-host $line
       python -m robot -d $result_path -T $line
}

