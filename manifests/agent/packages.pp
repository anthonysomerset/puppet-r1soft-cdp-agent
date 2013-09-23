class serverbackup_cdp::agent::packages {
    if $operatingsystem == ('redhat' or 'centos') {
        if !defined(Package['kernel-devel']) {
            package { 'kernel-devel':
                ensure => installed,
                before => Package['serverbackup-enterprise-agent'],
            }
        }

        if !defined(Package['kernel-headers']) {
            package { 'kernel-headers':
                ensure => installed,
                before => Package['serverbackup-enterprise-agent'],
            }
        }
    }

    if $operatingsystem == ('debian') {
        # proxmox support
        if $kernelrelease  =~ /pve/ {
            package { "pve-headers-${kernelrelease}":
                ensure  => installed,
                before => Package['serverbackup-enterprise-agent'],
            }
        }
        else {
            package { "linux-headers-${kernelrelease}":
                ensure  => installed,
                before => Package['serverbackup-enterprise-agent'],
            }
        }
    }

    package { 'serverbackup-enterprise-agent':
        ensure  => installed,
        require => Class['serverbackup_cdp::repo'],
    }
}
