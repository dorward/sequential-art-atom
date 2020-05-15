#!/usr/bin/env perl
use strict;
use warnings;
use LWP::UserAgent;
use HTML::TreeBuilder::XPath;
use XML::Atom::SimpleFeed;
use Getopt::Long;

use lib qw{ ./lib };
use SADB::SCHEMA;

use constant URL => "https://www.collectedcurios.com/sequentialart.php";

my $db;
my $atom_file;
my $atom_url;
GetOptions(
  "db=s"        => \$db,
  "atom_file=s" => \$atom_file,
  "atom_url=s"  => \$atom_url,
) or die("Error in command line arguments\n");

die "All three arguments must be provided" unless ($db && $atom_file && $atom_url);

my $schema = SADB::SCHEMA->connect("dbi:SQLite:$db") || die($!);
my $rs = $schema->resultset('Sa');

my $ua = LWP::UserAgent->new(agent => "SequentialArt-UpdateSeeker/0.2");
my $response = $ua->get(URL);

if ($response->is_success) {
  my $tree = HTML::TreeBuilder::XPath->new_from_content($response->decoded_content);

  my ($number_element) = $tree->findnodes('//input');
  my ($image_element)  = $tree->findnodes('//*[@class="w3-image"]');
  my $num              = $number_element->attr('value');
  my $img              = $image_element->attr('src');

  my $row = $rs->find($num);

  unless ($row) {
    $rs->create({ id => $num, image => $img });
    my @recent = $rs->search({}, { order_by => 'id DESC', rows => 10 });

    my $feed = XML::Atom::SimpleFeed->new(
      title => 'Sequential Art',
      link  => URL,
      id    => $atom_url,
      link  => {
        rel  => 'self',
        href => $atom_url,
      },
    );

    foreach my $entry (@recent) {
      my $num = $entry->id;
      my $url = $entry->image;
      $feed->add_entry(
        title   => 'Sequential Art ' . $num,
        author  => "Phillip M Jackson",
        link    => URL . '?s=' . $num,
        id      => URL . 's=' . $num,
        content => {
          content => qq{<div><img src="https://www.collectedcurios.com/$url" alt="" /></div>},
          type    => 'xhtml'
        }
      );
    }
    open(my $fh, '>', $atom_file) or die $!;
    print $fh $feed->as_string;
  }
} else {
  die sprintf("Error reading URL. Status [%s]", $response->status_line);
}

