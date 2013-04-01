class riemann::tools::service {
  service {'riemann-health':
    ensure     => running,
    enable     => $riemann::tools::health_enabled,
    hasstatus  => true,
    hasrestart => true,
    provider   => $riemann::params::service_provider,
  }
  service {'riemann-net':
    ensure     => running,
    enable     => $riemann::tools::net_enabled,
    hasstatus  => true,
    hasrestart => true,
    provider   => $riemann::params::service_provider,
  }
}
