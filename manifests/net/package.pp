class riemann::net::package(
  $ensure = 'installed'
) inherits riemann::params {
  Package <| title == 'riemann-tools' |>
}