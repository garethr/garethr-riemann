require 'spec_helper'

describe 'riemann::dash', :type => :class do
  it { should include_class('riemann::dash::install')}
  it { should include_class('riemann::dash::service')}
  it { should contain_package('riemann-dash')}
  it { should contain_service('riemann-dash').with_provider('upstart')}
end
