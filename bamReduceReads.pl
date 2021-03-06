#!/usr/bin/env perl

use strict;
use warnings;
use File::Spec;



my $PI = `echo $$` ;    chomp($PI) ;

#debug 
my $debug = 0 ; 

if (@ARGV != 3) {
    print STDERR "usage: $0 bam output threads \n" ; 
    print STDERR "This is for Tsai's T1D data \n" ; 

    exit(1);
}

my $ref = "/home/ishengtsai/db/hg19/ucsc.hg19.fasta" ;
my $gatkjar = "/home/ishengtsai/bin/GenomeAnalysisTK-2.7-2-g6bda569/GenomeAnalysisTK.jar" ;  



my $bam = shift ; 
my $output = shift ; 
my $cpu = shift ; 


#java set
system("java -Xmx6g -version ; ulimit -v 20000000 ") ; 
print "Number of CPU: $cpu\n" ; 



# reduce reads!
system_call("java -Xmx6g -jar $gatkjar -T ReduceReads -nct $cpu -R $ref -I $bam -o $output") ; 


# usage: system_call(string)
# Runs the string as a system call, dies if call returns nonzero error code
sub system_call {
    my $cmd  = shift;
    print "$cmd\n";
    system($cmd) ; 

}
