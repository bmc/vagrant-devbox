This repo contains the [Vagrant][] configuration and [Chef][] recipes for
spinning up an [Ubuntu][] Oneiric Ocelot (11.10) Server development box, under
a Vagrant-managed virtual machine.

The Vagrantfile uses [Chef][] recipes from this repository and from my
[common Chef repository][].

Props to [Toby DiPasquale](https://github.com/codeslinger) for providing
both an Oneiric box file and a similar repo with juicy bits ripe for the
cribbing.

**NOTE** This Vagrant setup relies on the [librarian][] gem to pull Chef
cookbooks down from various places on the web. Before running `vagrant up`,
run the following commands:

    $ gem install librarian  # You only have to do this once, obviously.
    $ librarian-chef install --clean

That pulls the various cookbooks down, stashing them locally.

[Vagrant]: http://vagrantup.com/
[Chef]: http://www.opscode.com/chef/
[Ubuntu]: http://www.ubuntu.com/
[common Chef repository]: https://github.com/bmc/chef-repo
[librarian]: https://github.com/applicationsonline/librarian
