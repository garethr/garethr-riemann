source "http://rubygems.org"


group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.6.0'
  gem "puppet-lint"
  gem "rspec-puppet"
  gem "puppetlabs_spec_helper"
  gem "puppet-syntax"
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "puppet-blacksmith"
end
