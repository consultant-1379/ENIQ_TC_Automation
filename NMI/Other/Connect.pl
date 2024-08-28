#!/afs/seli.gic.ericsson.se/app/perl/5.8.9/bin/perl -w
##-----------------------------------------------------------
## COPYRIGHT Ericsson Radio Systems  AB 2011
##
## The copyright to the computer program(s) herein is the
## property of ERICSSON RADIO SYSTEMS AB, Sweden. The
## programs may be used and/or copied only with the written
## permission from ERICSSON RADIO SYSTEMS AB or in accordance
## with the terms and conditions stipulated in the agreement
## contract under which the program(s)have been supplied.
##-----------------------------------------------------------
##-----------------------------------------------------------
##
##   PRODUCT      :
##   CRA NUMBER
##   CRA NUMBER
##   PRODUCT REV  :
##   Document REV :
##   RESP         :zkhevai
##   DATE         : 22/09/2020
##
##   REV          :
##
##
##--------------------------------------------------------------

use strict;
use Getopt::Long;
use Expect;
use POSIX qw(strftime);
use File::Basename;
use File::Copy;

my $exp;
my $undef = undef;
my $logdir;
my $logfile;
my $server;
my $def=20;

sub ServerConnection
{
my $timeout = 10;

    $exp->expect($def, ['#', sub {$exp = shift; $exp->send("ssh  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@atvts4063.athtem.eei.ericsson.se\r");}]);
    if($exp->expect($timeout, 'Are you sure you want to continue connecting (yes/no)?')){
    $exp->send('yes' . "\n");
    }

    if($exp->expect($timeout, 'Are you sure you want to continue connecting (yes/no)')){
    $exp->send('yes' . "\n");
    }

    if($exp->expect($timeout, 'assword:')){
    $exp->send("shroot\r");
    }
}

###### Main Script #####

ServerConnection();

exit 0;
