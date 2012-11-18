require 'spec_helper'

describe 'riemann::dash', :type => :class do
  it { should include_class('riemann::dash::package')}
  it { should include_class('riemann::dash::service')}
  it { should contain_package('riemann-dash')}
  it { should contain_service('riemann-dash').with_provider('upstart')}

  context 'with custom dashboard configuration' do
    let(:params) { {'config_file' => '/etc/bob.rb'} }
    it { should contain_file('/etc/init/riemann-dash.conf').with_content(/bob.rb/)} 
  end
end
