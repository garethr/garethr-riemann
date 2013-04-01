class riemann::riak::package(
  $ensure = 'installed'
) inherits riemann::params { 
  ensure_packages($riemann::params::tools_packages)
  Package <| title == 'riemann-tools' |>
}