require 'spec_helper'

describe 'motd::message', :type => :define do
  let :title do
    'somename'
  end
  let :facts do
    {
      :osfamily         => 'RedHat',
      :concat_basedir   => '/dne',
    }
  end

  it { should include_class('motd') }

  context 'population via source file' do
    let :params do
      {
        :source  => '/somefile',
        :content => '',
      }
    end
    it { should contain_concat__fragment('somename').with_source('/somefile') }
  end

  context 'population via content param' do
    let :params do
      {
        :source  => '',
        :content => 'somecontent',
      }
    end
    it { should contain_concat__fragment('somename').with_content('somecontent') }
  end
end
