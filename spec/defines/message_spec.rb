require 'spec_helper'

describe 'motd::message', :type => :define do
  let :title do
    'somename'
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end


      context 'without params' do
        it { expect { is_expected.to compile}.to raise_error(/Must pass content to Motd::Message/) }
      end

      context 'population via content param' do
        let :params do
          {
            :content => 'somecontent',
          }
        end
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_class('motd') }
        it { is_expected.to contain_concat__fragment('somename').with_content('somecontent') }
      end
    end
  end
end
