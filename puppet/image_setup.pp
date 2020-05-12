package { 'nginx':
  ensure   => 'installed',
  provider => 'apt'
}

exec { 'nginx-run':
  command  => 'sudo service nginx start',
  provider => 'shell'
}

user { 'nick':
  ensure => 'present',
  groups => 'nick_group'
}

group { 'nick_group':
  ensure => 'present'
}
