# Class: cloudwatch::config
# =================
#
# ----------
# Authors: Salman Taherizadeh - Jozef Stefan Institute
#
# Copyright
# ----------
#
# It is meant to:
#     * Configure the Amazon CloudWatch Agent
#
#
class cloudwatch::config {
	
	# Generate each part of the command to run the Amazon CloudWatch Agent - Memory
	$memory_units_option = "--memory-units=${cloudwatch::memory_units_str}"
	if $cloudwatch::mem_util_probe 	{ $mem_util_option = "--mem-util" } else { $mem_util_option = "" }
	if $cloudwatch::mem_used_probe 	{ $mem_used_option = "--mem-used" } else { $mem_used_option = "" }
	if $cloudwatch::mem_used_incl_probe { $mem_used_incl_option = "--mem-used-incl-cache-buff" } else { $mem_used_incl_option = "" }
	if $cloudwatch::mem_avail_probe 	{ $mem_avail_option = "--mem-avail" } else { $mem_avail_option = "" }
	if $cloudwatch::swap_util_probe 	{ $swap_util_option = "--swap-util" } else { $swap_util_option = "" }
	if $cloudwatch::swap_used_probe 	{ $swap_used_option = "--swap-used" } else { $swap_used_option = "" }

	# Generate each part of the command to run the Amazon CloudWatch Agent - Disk
	$disk_space_units_option = "--disk-space-units=${cloudwatch::disk_space_units_str}"
	$disk_path_option = "--disk-path=${cloudwatch::disk_path}"
	if $cloudwatch::disk_space_probe 		{ $disk_space_option = "--disk-space-util" } else { $disk_space_option = "" }
	if $cloudwatch::disk_space_used_probe 	{ $disk_space_used_option = "--disk-space-used" } else { $disk_space_used_option = "" }
	if $cloudwatch::disk_space_avail_probe { $disk_space_avail_option = "--disk-space-avail" } else { $disk_space_avail_option = "" }

	# Generate each part of the command to run the Amazon CloudWatch Agent - Aggregation
	if $cloudwatch::aggregated_enabled and $cloudwatch::aggregated_only_enabled { $aggregated_option = "--aggregated=only" }
	else { if $cloudwatch::aggregated_enabled { $aggregated_option = "--aggregated" } else { $aggregated_option = "" } }

	# Generate each part of the command to run the Amazon CloudWatch Agent - Auto-scaling
	if $cloudwatch::auto_scaling_enabled and $cloudwatch::auto_scaling_only_enabled { $auto_scaling_option = "--auto-scaling=only" }
	else { if $cloudwatch::auto_scaling_enabled { $auto_scaling_option = "--auto-scaling" } else { $auto_scaling_option = "" } }

	# Call the script from cron
	if $cloudwatch::from_cron_enabled { $from_cron_option = "--from-cron" } else { $from_cron_option = "" }
	
	# Identify the caller of the CloudWatch API
	if $cloudwatch::aws_access_key_id and $cloudwatch::aws_secret_key {
		$caller_identification_option = "--aws-access-key-id=${cloudwatch::aws_access_key_id} --aws-secret-key=${cloudwatch::aws_secret_key} "
	} else {
		if $cloudwatch::aws_iam_role { $caller_identification_option = "--aws-iam-role=${cloudwatch::aws_iam_role}" }
		else { fail("Please provide whether an IAM role or aws-access-key-id and aws-secret-key.") }
	}
	
	# The command to start collecting metrics and sending the measured values to Amazon CloudWatch.
	$mon_put_instance_data_pl = "
		${cloudwatch::cloudwatch_monitoring_scripts_folder}/${cloudwatch::extracted_folder_name}/${cloudwatch::monitoring_scripts_file} 
		${memory_units_option} ${mem_util_option} ${mem_used_option} ${swap_util_option} 
		${aggregated_option} 
		${auto_scaling_option} 
		${from_cron_option} 
		${caller_identification_option}"

}

