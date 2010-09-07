# Suffix

My personal site.

## Installation

### Prerequisites

* Ubuntu doesn't like to build the RMagick gem without help, get the [devel](http://snippets.dzone.com/posts/show/4140) packages first.
* Rails 3 requires Bundler 1.0, get it before deploying.
* Run a `git clone` on the server first and accept the GitHub signature.

### Capistrano

    $ cap production deploy:setup
    $ mkdir -p shared/config

Add the database.yml and config.yml here...

    $ cap production deploy:cold

### Apache

Fix the document root in the Suffix Apache config (add the current directory) and restart Apache.

    DocumentRoot /home/suffix/public_html/current/public
