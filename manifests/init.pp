class vpn(
  $inet_dev='eth0',
  $ip_addr,
  $vpn_nr,
  $secret_key
) {
  apt::source { 'universe-factory':
    comment  => 'This repo includes a fastd release',
    location => 'http://repo.universe-factory.net/debian/',
    release  => 'sid',
    repos    => 'main',
  }

  # install gateway packages
  package { ['bridge-utils', 'fastd', 'openvpn', 'batctl', 'radvd', 'tayga']:
    ensure => installed,
  }
  exec {
    'enable_batman_mod':
      command => 'echo batman-adv >> /etc/modules',
      unless  => 'grep -q ^batman-adv /etc/modules',
      path    => ['/bin', '/usr/sbin'],
  }

  # radvd configuration
  # setting up bat0
  file { '/etc/radvd.conf':
    ensure  => present,
    mode    => '0600',
    content => template('vpn/radvd.conf.erb'),
  }

  # tayga configuration
  file { '/etc/tayga.conf':
    ensure  => present,
    mode    => '0600',
    content => template('vpn/tayga.conf.erb'),
  }

  # fastd configuration
  file { '/etc/fastd/fastd.conf':
    ensure  => present,
    mode    => '0600',
    content => template('vpn/fastd.conf.erb'),
  }

  file { '/etc/fastd/secret.conf':
    ensure  => present,
    mode    => '0600',
    content => inline_template('secret "<%= @secret_key.chomp %>";');
  }

  # Start services
  service { 'radvd':
    ensure   => running,
    provider => init,
    enable   => true
  }

  service { 'tayga':
    ensure   => running,
    provider => init,
    enable   => true
  }

  service { 'fastd':
    ensure   => running,
    provider => init,
    enable   => true
  }
}