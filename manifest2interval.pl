#!/usr/bin/perl -w

use strict;
use Getopt::Std;

$Getopt::Std::STANDARD_HELP_VERSION = 1;

##########################################################################################
##	Script to convert Illumina Manifests files into Intervals.list GATK files	##
##	Also works for BED to intervals							##
##	david baux 10/2015								##
##	david.baux@inserm.fr								##
##########################################################################################



my (%opts, $file, $ext);
getopts('i:', \%opts);

if ((not exists $opts{'i'}) || ($opts{'i'} !~ /\.(txt|bed)/o)) {
	&HELP_MESSAGE();
	exit
}

if ($opts{'i'} =~ /(.+)\.(txt|bed)$/o) {$file = $1;$ext = $2;} #get file path and prefix

my $regexp = '^\d+\s+(chr[\dXY]+)\s+(\d+)\s+(\d+)\s+';
my $bed = '';
if ($2 eq 'bed') {$regexp = '^(chr[\dXY]+)\s+(\d+)\s+(\d+)\s+';$bed = 1}

my $intervals;

open(F, "$file.$ext") or die "$file $!";

while (<F>) {
	if (/$regexp/) {
		if ($bed == 1) {$intervals .= "$1:".($2+1)."-$3\n"}
		else {$intervals .= "$1:$2-$3\n"}
	}
}
close F;

open(G, , ">$file.Intervals.list") or die $!;

print G $intervals;

close G;

print "\nDone!!! output file: $file.Intervals.list\n\n";

exit;


sub HELP_MESSAGE {
	print "\nUsage: perl manifest2interval.pl -i path/to/manifest/file.txt or file.bed\nSupports --help or --version\n\n
### This script converts Illumina Manifests or BED files into Intervals.list GATK files
### Input is a .txt or .bed file, output is a .list file of format chr:start-end
### contact: david.baux\@inserm.fr\n\n"
}

sub VERSION_MESSAGE {
	print "\nVersion 1.0 18/10/2015\n"
}