Puppet module for installing and managing [Riemann](http://aphyr.github.com/riemann/),
the event agregation and monitoring tool.

This module is also available on the [Puppet Forge](https://forge.puppetlabs.com/garethr/riemann)

[![Puppet
Forge](http://img.shields.io/puppetforge/v/garethr/riemann.svg)](https://forge.puppetlabs.com/garethr/riemann)
[![Build
Status](https://secure.travis-ci.org/garethr/garethr-riemann.png)](http://travis-ci.org/garethr/garethr-riemann)
[![Dependency
Status](https://gemnasium.com/garethr/garethr-riemann.png)](http://gemnasium.com/garethr/garethr-riemann)


## Usage

The module includes three main components:

    include riemann
    include riemann::dash
    include riemann::tools

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

## Example

For a fully working example of this module you may also be interested in
the [riemann-vagrant
project](https://github.com/garethr/riemann-vagrant).

 # Archival Note 
 This repository is deprecated; therefore, we are going to archive it. However, learners will be able to fork it to their personal Github account but cannot submit PRs to this repository. If you have any issues or suggestions to make, feel free to: 
- Utilize the https://knowledge.udacity.com/ forum to seek help on content-specific issues. 
- Submit a support ticket along with the link to your forked repository if (learners are) blocked for other reasons. Here are the links for the [retail consumers](https://udacity.zendesk.com/hc/en-us/requests/new) and [enterprise learners](https://udacityenterprise.zendesk.com/hc/en-us/requests/new?ticket_form_id=360000279131).