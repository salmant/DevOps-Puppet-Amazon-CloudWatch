# Class: cloudwatch::install
# =================
#
# ----------
# Authors: Salman Taherizadeh - Jozef Stefan Institute
#
# Copyright
# ----------
# 
# It is meant to:
#     * Install the Amazon CloudWatch Agent
#
#
class cloudwatch::install {
	
	# Because we would like to use the ensure_resource() function
	include stdlib
	
	# If you check the following web page, various Operating Systems need different packages to be installed.
	# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html
	# The package name of crontab in CentOS / RedHat / Amazon Linux is cronie and cron in Ubuntu / Debian Linux. 
	case $::operatingsystem {
		"Amazon": {
			$packages = ['unzip', 'perl-Switch', 'perl-DateTime', 'perl-Sys-Syslog', 'perl-LWP-Protocol-https', 'perl-Digest-SHA.x86_64', 'cronie']
		}
		"Ubuntu","Debian": {
			$packages = ['unzip', 'libwww-perl', 'libdatetime-perl', 'cron']
		}
		"CentOS","RedHat": {
			if $operatingsystemrelease == /^7.*/ { 
				$packages = ['zip', 'unzip', 'perl-Switch', 'perl-DateTime', 'perl-Sys-Syslog', 'perl-LWP-Protocol-https', 'perl-Digest-SHA', 'cronie']
			}else {
				if $operatingsystemrelease == /^6.*/ { 
					$packages = ['zip', 'unzip', 'perl-DateTime', 'perl-CPAN', 'perl-Net-SSLeay', 'perl-IO-Socket-SSL', 'perl-Digest-SHA', 'cronie']
				}
			}
		}
		default: {
			fail("${::operatingsystem} is not supported by Amazon CloudWatch.")
		}
	}
	
	# Make sure that the crontab service is running
	# The service name of crontab in CentOS / RedHat / Amazon Linux is crond and cron in Ubuntu / Debian Linux. 
	case $::osfamily {
		"Ubuntu","Debian": { $service_name = 'cron' }
		"CentOS","RedHat","Amazon": { $service_name = 'crond' }
	}
	service { 'cron_or_crond':
		name   => $service_name,
		ensure => 'running',
		enable => true
	}
	
	# Creates base directory
	file { $cloudwatch::cloudwatch_monitoring_scripts_folder :
		ensure  => 'directory',
		owner  => 'root',
		mode    => '0755',
		recurse => true
	}

	# The ensure_resource() function is a call that you can use to add package resources to the catalog. 
	# It is included in the puppetlabs/stdlib module and is not available in a base Puppet install.
	# Therefore, we add "include stdlib" at the beggining of this class
	ensure_resource('package', $packages, {'ensure' => 'present'})
	# If any of required packages are already installed by some other classes, it would be skipped. 

	# Download and extract the CloudWatch Monitoring Scripts ZIP file.
	# The basename() function returns the name of a file without the path of the file.
	$monitoring_scripts_package_name = basename($cloudwatch::download_link)
	archive { $monitoring_scripts_package_name:
		path			=> "/tmp/${monitoring_scripts_package_name}",
		extract			=> true,
		extract_path	=> $cloudwatch::cloudwatch_monitoring_scripts_folder,
		source			=> $cloudwatch::download_link,
		creates			=> "${cloudwatch::cloudwatch_monitoring_scripts_folder}/${cloudwatch::extracted_folder_name}",
		cleanup			=> true,
		require			=> Package[$packages]
	}

}

