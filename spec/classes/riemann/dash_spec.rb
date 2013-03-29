require 'spec_helper'

describe 'riemann::dash', :type => :class do
  it { should create_class('riemann::dash::install')}
  it { should create_class('riemann::dash::config')}
  it { should create_class('riemann::dash::service')}
  it { should include_class('gcc')}
  it { should contain_package('riemann-dash')}
  it { should contain_service('riemann-dash').with_provider('upstart')}
  it { should contain_file('/etc/riemann-dash.rb').with_content(/localhost/)}
  it { should contain_file('/etc/riemann-dash.rb').with_content(/4567/)}

  context 'passing a custom port' do
    let(:params) { {'port' => 6000} }
    it { should contain_file('/etc/riemann-dash.rb').with_content(/6000/)}
  end

  context 'passing a custom host' do
    let(:params) { {'host' => '0.0.0.0'} }
    it { should contain_file('/etc/riemann-dash.rb').with_content(/0\.0\.0\.0/)}
  end

  context 'with an invalid host name' do
    let(:params) { {'host' => true} }
    it do
      expect {
        should contain_package('riemann-dash')
      }.to raise_error(Puppet::Error)
    end
  end

end
