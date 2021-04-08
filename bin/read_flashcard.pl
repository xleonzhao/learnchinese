#!/usr/bin/env perl

my $fcdir     = "../flashcard";
my $flashcard = "$fcdir/chinese2500.txt";

open(FP, "<$flashcard") || die("cannot open $flashcard");

my $max   = 1000;
my $count = 1;
my $start = 0;
my $output;

while(<FP>) {
    chomp();

    if( $_ =~ /^Text 1/) {
	$start = 1;
	next;
    }
    next if (! $start);

    if( $_ =~ /汉字/) {
	if( defined $output ) {
	    close(WP);
	    $count++;
	    last if($count > $max);
	    print STDERR "start outputing to $output\n";
	}
	
	$output = "$fcdir/$count.txt";
	open(WP, ">$output") || die("cannot open $output");
    }
    
    if( defined $output ) {
	print WP "$_\n";
    }
}

close(FP);
