# Class: cloudwatch::service
# =================
#
# ----------
# Authors: Salman Taherizadeh - Jozef Stefan Institute
#
# Copyright
# ----------
#
# It is meant to:
#     * Run the Amazon CloudWatch Agent via the software utility "cron"
#
#
class cloudwatch::service {
	
	# "cron" is a Linux utility which schedules a command or script on your server to run automatically at a specified time and date. 
	# A cron job is the scheduled task itself. Cron jobs can be very useful to automate repetitive tasks.
	# Every cron resource created by Puppet requires a command and at least one periodic attribute (hour, minute, month, monthday, weekday, or special).
	cron { 'periodically_send':
		ensure		=> 'present',
		user		=> 'root',
		minute		=> $cloudwatch::monitoring_interval_minutes,
		hour		=> '*',
		command		=> regsubst($cloudwatch::config::mon_put_instance_data_pl, '\s+', ' ', 'G')
	}

}

