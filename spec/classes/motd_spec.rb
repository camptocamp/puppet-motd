require 'spec_helper'

describe 'motd', :type => :class do
  context 'on a Debian Squeeze OS' do
    let :facts do
      {
        :osfamily         => 'Debian',
        :lsbdistcodename  => 'squeeze',
      }
    end
    it { should contain_exec('update motd').with(
      refreshonly => true,
      command => 'uname -snrvm > /var/run/motd && cat /etc/motd.tail >> /var/run/motd',
    ) }
    it { should contain_concat('/etc/motd.tail').with(
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    ) }
  end

  context 'on a Debian Wheezy OS' do
    let :facts do
      {
        :osfamily         => 'Debian',
        :lsbdistcodename  => 'wheezy',
      }
    end
    it { should contain_exec('update motd').with(
      refreshonly => true,
      command => 'true',
    ) }
    it { should contain_concat('/etc/motd').with(
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    ) }
  end

  context 'on a RedHat OS' do
    let :facts do
      {
        :osfamily         => 'RedHat',
      }
    end
    it { should contain_exec('update motd').with(
      refreshonly => true,
      command => 'true',
    ) }
    it { should contain_concat('/etc/motd').with(
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    ) }
  end
end
