# alisio

This is a command-line tool that posts an image-preview of a recent blog post to Twitter, complete with a call-to-action to read the full post at the blog's own website. It adds an appropriate hyperlink to the tweet's text, in an attempt to make this easy Twitter-browsing humans and others.

When configured with a Twitter account and a blog's Atom feed, this program upon invocation will fetch that blog's basic information and most recent post, then create a new tweet containing the following elements:

* The blog's name

* The title of the most recent post

* A link to the most recent post

* **And this is the kicker —** An image containing the most recent post's first paragraph, followed by an exhortation to read the rest of the post by clicking the attached link or just going to the blog's front page.

    Furthermore, if the post contains at least one image (via an ordinary HTML `<img>` tag), then alisio will work that illustration into the resulting image, recoloring its output text and background so that everything looks reasonably good.

Alternately, the program can just write the image to your local filesystem instead of posting it to Twitter.

## Example output

![Screenshot of an alisio-generated tweet](http://fogknife.com/images/posts/alisio_example_2.png)

## Installation

### Prerequisites

You can find all this tool's prerequisite software through your favorite package manager (`brew` or `yum` or `apt-get` or whatever).

* [ImageMagick](http://www.imagemagick.org), giving you the `mogrify`, `convert`, and `identify` command-line programs.

* [libxml2](http://www.xmlsoft.org). (If the command `xml2-config --version` returns something that looks like a version number, you're probably OK.)

* Optional: [wkhtmltopdf](https://wkhtmltopdf.org), giving you the `wkhtmltoimage` command-line program. If installed, then you can invoke alisio with the `--preserve_markup` option, allowing its output image to retain the original text's inline markup.

### Perl modules

If you enjoy blindly running `curl | bash` invocations straight off of GitHub README files as much as I do, then you can just do this:

    curl -fsSL https://cpanmin.us | perl - --installdeps .
    
More conservative users can install [cpanm](https://github.com/miyagawa/cpanminus) manually and then run `cpanm --installdeps .` instead.

## Configuration

Copy conf/alisio-example.conf to conf/alisio.conf, then update as the file itself directs. (You can instead copy the file to some other location and then tell alisio about it at runtime, per "Usage", below.)

In order to fill in all four required consumer/access-token keys, you will probably need to go to [apps.twitter.com](http://apps.twitter.com) and register a new app and then give yourself access tokens to it.

## Usage

If the config file is "../config/alisio.conf" relative to the alisio script's location on the filesystem, just run it with no arguments.

Otherwise, run it like so:

    alisio --config_file=/path/to/alisio.conf

If you would like it to output a local file rather than make a Twitter post, use the `preview` option:

    alisio --config_file=/path/to/alisio.conf --preview=my_image.png
    
More command-line options exist, and you can `man` or `perldoc` the alisio program file to learn about them.

## Bugs and TODO

This is beta software. Its author is still figuring out how it wants to work, and the interface might still change. Use at your own risk.

Known issues:

* Rather inflexible. (Can't customize the call-to-action text, for example.)

* It should really be able to work with both Atom and RSS. Well, it doesn't.

* Blog posts with absurdly long titles will make the tweet-post fail silently.

* Unexpected uses of the `<link>` element in the Atom document can make the program fail.

## Blame

Jason McIntosh ([jmac@jmac.org](mailto:jmac@jmac.org), GitHub: [jmacdotorg](https://github.com/jmacdotorg), Twitter: [@jmacdotorg](http://twitter.com/jmacdotorg)) created this tool. Questions, comments, et cetera to him. Pull requests always welcome. Thanks!
