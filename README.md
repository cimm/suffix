# Suffix

My personal site.

## Installation

### Prerequisites

* Ubuntu doesn't like to build the RMagick gem without help, get the [devel](http://snippets.dzone.com/posts/show/4140) packages first.
* Rails 3 requires Bundler 1.0, get it before deploying.
* Run a `git clone` on the server first and accept the GitHub signature.

### Certificate

Create a certificate for the application user on the remote server and make sure to add a passphrase. Next [configure ssh-agent](http://help.github.com/working-with-key-passphrases/) to fill in the passphrase when asked for (saves you a lot of trouble later on). Check the `set :ssh_options, { :forward_agent => true }` setting in the Capistrano deploy file or it won't work.

### Capistrano

Launch the Capistrano setup from you **local** machine:

    $ cap production deploy:setup

Create the config directory on the **remote** server and add the database.yml and config.yml files:

    $ mkdir -p shared/config

Run the cold deploy task from your **local** machine. You should be good to go now.

    $ cap production deploy:cold

### Apache

Fix the document root in the Suffix Apache config (add the *current* directory) and restart Apache.

    DocumentRoot /home/suffix/public_html/current/public
