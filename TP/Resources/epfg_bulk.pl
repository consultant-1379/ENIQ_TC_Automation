#!/usr/bin/perl

use strict;
use warnings;
no warnings 'uninitialized';
use Data::Dumper;

my ($secs,$mins,$hours,$mdays,$mons,$years,$wdays, $ydays,$isdsts)=localtime( time + 86400 );
$mons++;
$years=1900+$years;
my $yesterdayDate = sprintf "%02d-%02d-%4d", $mdays,$mons,$years;
 

############################################################### Copying Files from Storage(TopologyFiles) to Server(Predefined Path)
# sub copyFilesFromTopoToServer{
# 	my $topologyFile = $_[0];
# 	my $string = $_[1];
# 	my $dir = $_[2];
# 	my $srcPath = $topologyFile.$string;
# 	my $targetPath = '/eniq/data/pmdata/eniq_oss_1/'.$dir;
# 	print "SourcePath : $srcPath \n TargetPath: $targetPath \n";
# 	system ("mkdir -p $targetPath ") == 0 or die "failed to create a directory $targetPath\n";
# 	system ("cp -R $srcPath $targetPath");
# }

sub epfgdataGeneration{
	my ($line);
	my $i;
	my @array;
	my @query_array;
	my $key;
	my $path;
	my $epfgpropertiesfile = '/eniq/home/dcuser/epfg/config/epfg.properties';
	#my $topologyFile = 'eniq/home/dcuser/TopologyFiles/';
	
	#my $file = '/eniq/home/dcuser/data.txt';
	#open FILE, '<', $file or die "Could not open '$file', No such file found in the provided path $!\n";
	#print <FILE>;
	print "Enter TP name :\n";
	my $Tpname=<STDIN>;
	@array = ($Tpname);
	print "@array\n";
	#close(FILE);
	my $count = @array;

###############################################################
	
	for ($i=0;$i<$count;$i++) {
		undef $line;
		$line = shift @array;
		chomp $line;
		print "$line\n";
		my ($d,$string,$r,$b) = $line  =~ m/(DC_\w_|DIM_\w_)(\w*)(\_R.+\_b)(\d+)/;
		print "$d hi...." ;
		print "$string\n";
		################################ List of gen flags from epfg.properties file 
		my %PmGenNodes = (
				"BULK_CM" => ["enableLteBCGCmdata","enableERBSG2BCGCmdata","enableRncBCGCmdata","enableRbsBCGCmdata","enableRxiBCGCmdata","enableGsmBCGCmdata","enableNrBCGCmdata","enableMgwBCGCmdata","enableMscApgBCGCmdata","enableMscIogBCGCmdata","enableMscBcBCGCmdata","enableRanosBCGCmdata"]
			);
		
		my %PmDirList = (
				
				"BULK_CM" => ["/bulkcm/"]	 	
			);
		my @keys = keys %PmGenNodes;
			
			###########################################################	Checking DC Techpack
		if ( $d =~ m/(^DC_\w*)/ ) {	
			
			# opendir my $tpDir, $topologyFile or die "Cannot open directory:$topologyFile $!";
			# print "$topologyFile\n";
			# print "$tpDir\n";
			# #my @tpDirList = readdir $tpDir;
			# # foreach my $i (@tpDirList){
			# # print ("$i\n");
			# # }
			# closedir $tpDir;
			# my $temp = $topologyFile;
			# my @tpDirList = glob( $temp );
			# foreach (@tpDirList)
			#  {   print $_ . "\n";}
			# print "string-> $string\n";
			# if ($string ~~ @tpDirList){
			# 	print "string found $string\n";
			# 	my $storage = $topologyFile.$string.'/';
			# 	opendir my $dirs, $storage."/" or die "Cannot open directory:$topologyFile.$string $!";
			# 	my @dirList = grep { !/^\.\.?$/ } readdir $dirs;
			# 	closedir $dirs;
			# 	my $dirSize = scalar @dirList;
			# 	if ( $dirSize > 0 ) {
			# 		print "inside dir $dirSize\n";
			# 		my @dirArray = @{$PmDirList{$string}};
			# 		my $size = scalar @dirArray;
			# 		if ($size == 1) {
			# 			print "copy function called";
			# 			#copyFilesFromTopoToServer($topologyFile,$string."/*",$dirArray[0]);
			# 		} 
			# 		if ( $size > 1 ) {
			# 			my @seprateDir;
			# 			for my $dir (@dirArray) {
			# 				my @dirName = split(':', $dir); 
			# 				if( defined $dirName[1]) {
			# 					push(@seprateDir, $dirName[1]);
			# 				}
			# 			}
			# 			for my $dir (@dirArray) {
			# 				my @dirName = split(':', $dir); 
			# 				if( defined $dirName[1]) {
			# 					for my $folder (@dirList) {
			# 						if( $folder ~~ @seprateDir) {
			# 							#copyFilesFromTopoToServer($topologyFile,$string."/".$folder."/",$dirName[0]);
			# 						}
			# 					}
			# 				} else {
			# 					for my $folder (@dirList) {
			# 						if ( !($folder ~~ @seprateDir) ) {
			# 							#copyFilesFromTopoToServer($topologyFile,$string."/".$folder."/",$dirName[0]);
			# 						}
			# 					}
			# 				}
			# 			}
			# 		}
			# 		sleep (60);
			# 	} else {
			# 		print "$string directory is not exists under the $topologyFile";
			# 	}
			# }
			if ($string ~~ @keys){

				print "From hash : @{$PmGenNodes{$string}}\n";
				@query_array = @{$PmGenNodes{$string}};
				print "From condition : @query_array\n";				
				my ($count1,$j);
				$count1 = @{$PmGenNodes{$string}};
				print "$count1\n";
				
				##################################################### Changing the GenFlag, StartTime and EndTime
				for ($j=0;$j<$count1;$j++){
					my $genflag = $query_array[$j];
					my $flagName = substr($genflag,0, -7);
					print "$j : $genflag\n";
					
					my $pattern = $genflag."=NO";
					my $new_pattern = $genflag."=YES";
					print "Pattern in epfg is $new_pattern\n";
								
					my $oldStartTime = $flagName."StartTime=";
					my $newStartTime = $flagName."StartTime=".$yesterdayDate."+10:00\n";
					
					my $oldEndTime = $flagName."EndTime=";
					print "endtime is $oldEndTime\n";
					my $newEndTime = $flagName."EndTime=".$yesterdayDate."+12:00\n";
					print "newendtime is $newEndTime\n";

					my $genTime = $flagName."genTime=";
					my $newgenTime = $flagName."genTime=".$yesterdayDate."+10:00\n";

					#my $MultipleOffsetGenFlag = "MultipleOffsetGenFlag=";
					open EPFGFILE, '<', $epfgpropertiesfile or die "Could not open '$epfgpropertiesfile', No such file found in the provided path $!\n";
					print $epfgpropertiesfile;
					my @epfg_lines = <EPFGFILE>;
					close(EPFGFILE);

					my @epfg_newlines;
					foreach(@epfg_lines) {
						$_ =~ s/$pattern/$new_pattern/g;
						if($_ =~ m/(^$oldStartTime)/ ) {
							$_ =~ s/$_/$newStartTime/g;
						}
						if($_ =~ m/(^$oldEndTime)/ ) {
							$_ =~ s/$_/$newEndTime/g;
						}
                        if($_ =~ m/(^$genTime)/ ) {
							$_ =~ s/$_/$genTime/g;
						}

						# if($_ =~ m/($MultipleOffsetGenFlag)/)
						# {
						# 	$_ =~ s/$_/"MultipleOffsetGenFlag=YES\n"/g;
						# }
						push(@epfg_newlines,$_);
					}
					open(EPFGFILE, ">/eniq/home/dcuser/epfg/config/epfg.properties") || die "File not found";
					print EPFGFILE @epfg_newlines;
					close(EPFGFILE);
				}
			}
		} 
		
		
		###########################################################	Checking DIM Techpack
		# if ( $d =~ m/(^DIM_\w*)/) {
		# 	print "topology directory -> ";
		# 	opendir my $tpDir, $topologyFile or die "Cannot open directory:$topologyFile $!";
		# 	my @tpDirList = readdir $tpDir;
		# 	closedir $tpDir;
			
		# 	if ($string ~~ @tpDirList){
				
		# 		opendir my $dir, $topologyFile.$string or die "Cannot open directory:$topologyFile.$string $!";
		# 		my @files = readdir $dir;
		# 		closedir $dir;
				
		# 		my $subDirpath = '/eniq/data/pmdata/eniq_oss_1/';
		# 		my $sourceDir = $topologyFile.$string.'/';
		# 		if (-d $sourceDir) {
		# 			my $src = $sourceDir."*";
		# 			print "SourcePath : $src \n TargetPath: $subDirpath \n";
		# 			system ("cp -R $src $subDirpath");
		# 		}
		# 	}
		# }
	}
}
	
	epfgdataGeneration();