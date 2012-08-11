Puppet module for installing and managing [Riemann](http://aphyr.github.com/riemann/),
the event agregation and monitoring tool.

This module is also available on the [Puppet Forge](https://forge.puppetlabs.com/garethr/riemann)

[![Build
Status](https://secure.travis-ci.org/garethr/riemann-vagrant.png)](http://travis-ci.org/garethr/riemann-vagrant)
[![Dependency
Status](https://gemnasium.com/garethr/riemann-vagrant.png)](http://gemnasium.com/garethr/riemann-vagrant)

## Usage

The module includes three main components:

    include riemann
    include riemann::dash
    class { 'riemann::tools': }

Riemann represents the Riemann daemon and associated configuration,
riemann:dash the dashboard and riemann:tools the client and a couple of
daemons for pushing example data into Riemann.

This is mainly useful either as a starting point or for experimentation
at present because you'll likely want to modify both the basic riemann
configuration and the dashboard views. Time permitting I'll make that
more comfigurable or simply split the relevant parts out.
