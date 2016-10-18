# Class for managing aide's cron job.
class aide::cron (
  $aide_path = $aide::params::aide_path,
  $mailto    = 'root',
) inherits aide {
  file { '/usr/sbin/aide-check':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
    content => template("${module_name}/aide-check.erb"),
  }
  cron { 'aide':
    command => '/usr/sbin/aide-check',
    user    => 'root',
    hour    => '*',
    minute  => $minute,
    require => [Package['aide'], Exec['install aide db'], File['/usr/sbin/aide-check']],
  }
}
