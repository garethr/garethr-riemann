class riemann::health::package(
  $ensure = 'installed'
) inherits riemann::params { 
  Package <| title == 'riemann-tools' |>
}