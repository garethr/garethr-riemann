require 'spec_helper'

describe 'riemann', :type => :class do
  it { should include_class('riemann::package') }
  it { should include_class('riemann::config') }
  it { should include_class('riemann::service') }
  it { should contain_class('wget')}
  it { should contain_file('/etc/riemann.sample.config') }
  it { should contain_file('/etc/puppet/riemann.yaml') }
  it { should contain_service('riemann').with_provider('upstart')}

  context 'passing a version number' do
    let(:params) { {'version' => '1.0.0'} }
    it { should contain_exec('untar_riemann').with_creates("/opt/riemann-1.0.0")}
  end

  context 'passing a config file' do
    let(:params) { {'config_file' => '/etc/bob/riemann.config'} }
    it { should contain_file('/etc/init/riemann.conf').with_content(/bob/)}
  end

end