#!/usr/bin/env perl

use warnings;
use strict;

use Test::More;
use FindBin;

use Path::Class;
use File::Temp;

my $no_image_feed_file = make_feed_file( 'no_image.xml' );
my $with_image_feed_file = make_feed_file( 'with_image.xml' );

test_height( $no_image_feed_file, 381 );
test_height( $with_image_feed_file, 595 );

done_testing();

sub test_height {
    my ( $feed_file, $desired_height ) = @_;

    my $output_file = File::Temp->new;

    system( "$FindBin::Bin/../bin/alisio --preview=$output_file "
            . "--feed_url=file://$feed_file" );

    my $real_height = `identify -ping -format '%h' $output_file`;

    is ( $real_height, $desired_height );
}


sub make_feed_file {
    my ( $template_filename ) = @_;

    my $template_file = Path::Class::File->new(
        "$FindBin::Bin",
        'feed_templates',
        $template_filename,
    );

    my $xml = $template_file->slurp;

    my $image_file = Path::Class::File->new(
        "$FindBin::Bin",
        'img',
        'unicorn.png',
    );

    $xml =~ s/\[% image_path %\]/$image_file/g;

    my $feed_file = File::Temp->new;
    print $feed_file $xml;

    return $feed_file;
}
