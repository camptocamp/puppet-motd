require 'spec_helper'

describe 'motd', :type => :class do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end

      it { is_expected.to compile.with_all_deps }
      case facts[:osfamily]
      when 'Debian'
        case facts[:lsbdistcodename]
        when 'wheezy'
          it { is_expected.to contain_exec('update motd').with({
            :refreshonly => true,
            :command => 'true',
          }) }
          it { is_expected.to contain_concat('/etc/motd').with({
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644',
          }) }
        else
          it { is_expected.to contain_exec('update motd').with({
            :refreshonly => true,
            :command => 'uname -snrvm > /var/run/motd && cat /etc/motd.tail >> /var/run/motd',
          }) }
          it { is_expected.to contain_concat('/etc/motd.tail').with({
            :owner  => 'root',
            :group  => 'root',
            :mode   => '0644',
          }) }
        end
      else
        it { is_expected.to contain_exec('update motd').with({
          :refreshonly => true,
          :command => 'true',
        }) }
        it { is_expected.to contain_concat('/etc/motd').with({
          :owner  => 'root',
          :group  => 'root',
          :mode   => '0644',
        }) }
      end
    end
  end
end
