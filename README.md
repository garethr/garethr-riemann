Puppet module for installing and managing [Riemann](http://aphyr.github.com/riemann/),
the event agregation and monitoring tool.

This module is also available on the [Puppet Forge](https://forge.puppetlabs.com/garethr/riemann)

[![Build
Status](https://secure.travis-ci.org/garethr/garethr-riemann.png)](http://travis-ci.org/garethr/garethr-riemann)
[![Dependency
Status](https://gemnasium.com/garethr/garethr-riemann.png)](http://gemnasium.com/garethr/garethr-riemann)

## Usage

The module includes three main components:

    class { 'riemann':
		  before => [
			  Class['riemann::dash'],
				Class['riemann::health'],
				Class['riemann::net'],
				Class['riemann::riak]
		  ]
	  }
    include riemann::dash
    include riemann::health
    include riemann::net
    include riemann::riak

Riemann represents the Riemann daemon and associated configuration,
riemann:dash the dashboard and riemann::tools the client and a couple of
daemons for pushing example data into Riemann.

## Configuration

The riemann class has some defaults that can be overridden, for
instance if you wanted a specific version of riemann:

    class { 'riemann': version => '0.1.1' }

More useful is probably the ability to override the default
configuration file.

    class { 'riemann': config_file => '/etc/riemann.config' }

In this last case you're responsible for making sure that file exists,
via another puppet resource or otherwise.

The dashboard class can also be configured by providing your own views
and controllers. As an example the sample class is provided in riemann::dash.
The riemann::dash class can be called as follows:

    class { 'riemann::dash': config_file => '/etc/riemann-dash.rb' }

For more information about how to create custom dashboards see the
[riemann-dash repository](https://github.com/aphyr/riemann-dash).

## Example

For a fully working example of this module you may also be interested in
the [riemann-vagrant
project](https://github.com/garethr/riemann-vagrant).
