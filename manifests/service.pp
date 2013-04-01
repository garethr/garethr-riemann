class riemann::service {
  service {'riemann':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => $riemann::params::service_provider,
  }
}
