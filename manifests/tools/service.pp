class riemann::tools::service {
  service {'riemann-health':
    ensure     => running,
    enable     => $health_enabled,
    hasstatus  => true,
    hasrestart => true,
    provider   => upstart,
  }
  service {'riemann-net':
    ensure     => running,
    enable     => $net_enabled,
    hasstatus  => true,
    hasrestart => true,
    provider   => upstart,
  }
}
