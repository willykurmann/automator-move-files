#!/usr/bin/perl
#
# file_destination.pl
# Check through a list of rules if the given filename passed as argument match a specific pattern.
# If it does, the script returns the corresponding destination folder.
# Otherwise,  a default destination folder is returned.

use strict;
use XML::Simple;

my $filename = $ARGV[0];
my $rules_xml_file = $ARGV[1];

my $parser = XML::Simple->new( KeepRoot => 1 );
my $doc = $parser->XMLin($rules_xml_file,ForceArray=>['filename_rule']);
my $destination_folder = $doc->{filename_rules}->{no_matching_rule_destination_folder};
my @filename_rules = @{$doc->{filename_rules}->{filename_rule}};

foreach my $filename_rule (@filename_rules){
	my $filename_rule_pattern = $filename_rule->{pattern};
	my $filename_rule_destination_folder = $filename_rule->{destination_folder};
	if($filename =~ /$filename_rule_pattern/){
		$destination_folder = $filename_rule_destination_folder;
		last;
	}
}

print $destination_folder;
exit 0;