require 'spec_helper'

describe 'motd::message', :type => :define do
  let :title do
    'somename'
  end

  it { should include_class('motd') }

  context 'population via source file' do
    let :params do
      {
        :source  => '/somefile',
        :content => '',
      }
    end
    it { should contain_concat_fragment('somename').with(
      source  => '/somefile',
      content => undef,
    ) }
  end

  context 'population via content param' do
    let :params do
      {
        :source  => '',
        :content => 'somecontent',
      }
    end
    it { should contain_concat_fragment('somename').with(
      source  => undef,
      content => 'somecontent',
    ) }
  end
end
