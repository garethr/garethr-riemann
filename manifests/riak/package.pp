class riemann::riak::package(
  $ensure = 'installed'
) inherits riemann::params {
  Package <| title == 'riemann-tools' |>
}