puppet-bprd
===========

Bastard Puppet Runtime Daemon

This is really something that would be more of a sinatra app, that will allow a web interface to add hosts, usernames / passwords (or ssh keys), and use the net::ssh library to upload the PE installer and push an answers file to it.

Since net::ssh actually lets us (somewhat easily) run commands remotey and process that output locally, we could do some mini facter parsing (or atleast parse uname-r, to choose the release specific build of the installer to push).



