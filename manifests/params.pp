# Class: cloudwatch::params
# ==================================================
#
# ----------
# Authors: Salman Taherizadeh - Jozef Stefan Institute
#
# Copyright
# ----------
#
# List of parameters defined for the module.
#
# Variables
# ----------
# * $aws_access_key_id						: The --aws-access-key-id and --aws-secret-key parameters are used to identify the caller of the CloudWatch API. Do not use this option with the --aws-iam-role parameter.
# * $aws_secret_key        					: The --aws-access-key-id and --aws-secret-key parameters are used to identify the caller of the CloudWatch API. Do not use this option with the --aws-iam-role parameter.
# * $aws_iam_role							: The IAM role is used to provide AWS credentials to identify the caller. Do not use this option with the --aws-access-key-id or --aws-secret-key parameters.
# * $cloudwatch_monitoring_scripts_folder	: A folder where you want to store the CloudWatch Monitoring Scripts
# * $download_link							: Download link of the CloudWatch Monitoring Scripts ZIP file
# * $monitoring_scripts_file 				: mon-put-instance-data.pl --> This file collects system metrics on an Amazon EC2 instance and sends them to Amazon CloudWatch.
# * $extracted_folder_name					: Extracted folder's name of CloudWatchMonitoringScripts-1.2.2.zip
# * $monitoring_interval_minutes			: The time interval to send the monitoring data to Amazon CloudWatch.
# * $memory_units_str						: Specifies units in which to report memory usage.
# * $mem_util_probe							: Collects and sends the MemoryUtilization metrics in percentages.
# * $mem_used_probe							: Collects and sends the MemoryUsed metrics, reported in megabytes.
# * $mem_used_incl_probe					: If you include this option, memory currently used for cache and buffers is counted as "used" when the metrics are reported for --mem-util, --mem-used, and --mem-avail.
# * $mem_avail_probe						: Collects and sends the MemoryAvailable metrics, reported in megabytes.
# * $swap_util_probe						: Collects and sends SwapUtilization metrics, reported in percentages.
# * $swap_used_probe						: Collects and sends SwapUsed metrics, reported in megabytes.
# * $disk_space_units_str					: Specifies units in which to report disk space usage.
# * $disk_path								: Selects the disk on which to report.
# * $disk_space_probe						: Collects and sends the DiskSpaceUtilization metric for the selected disks. The metric is reported in percentages.
# * $disk_space_used_probe					: Collects and sends the DiskSpaceUsed metric for the selected disks. The metric is reported by default in gigabytes.
# * $disk_space_avail_probe					: Collects and sends the DiskSpaceAvailable metric for the selected disks. The metric is reported in gigabytes.
# * $aggregated_enabled						: Adds aggregated metrics for instance type, AMI ID, and overall for the region. 
# * $aggregated_only_enabled				: The value =only is optional; if specified, the script reports only aggregated metrics.
# * $auto_scaling_enabled					: Adds aggregated metrics for the Auto Scaling group. 
# * $auto_scaling_only_enabled				: The value =only is optional; if specified, the script reports only Auto Scaling metrics. 
# * $from_cron_enabled						: Use this option when calling the script from cron. If the script encounters an error, it writes the error message in the system log. When this option is used, all diagnostic output is suppressed, but error messages are sent to the local system log of the user account.
# ----------
#
#
class cloudwatch::params {

	$aws_access_key_id = "XXXXXXXXXXXXXXXXXXXX" # --aws-access-key-id=VALUE
	$aws_secret_key = "YYYYYYYYYYYYYYYYYYYYY" # --aws-secret-key=VALUE
	$aws_iam_role = undef # --aws-iam-role=VALUE
	$cloudwatch_monitoring_scripts_folder = "/cloudwatch-monitoring-scripts"
	$download_link = "https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip"
	$monitoring_scripts_file = "mon-put-instance-data.pl"
	$extracted_folder_name = "aws-scripts-mon"
	$monitoring_interval_minutes = '*/1' # means every 1 minute
	$memory_units_str = "megabytes" # --memory-units=UNITS
	$mem_util_probe = true # --mem-util
	$mem_used_probe = true # --mem-used
	$mem_used_incl_probe = true # --mem-used-incl-cache-buff
	$mem_avail_probe = true # --mem-avail
	$swap_util_probe = true # --swap-util
	$swap_used_probe = true # --swap-used
	$disk_space_units_str = "gigabytes" # --disk-space-units=UNITS
	$disk_path = '/' # --disk-path=PATH
	$disk_space_probe = true # --disk-space-util
	$disk_space_used_probe = true # --disk-space-used
	$disk_space_avail_probe = true # --disk-space-avail
	$aggregated_enabled = false # --aggregated[=only]
	$aggregated_only_enabled = false # --aggregated[=only]
	$auto_scaling_enabled = false # --auto-scaling[=only]
	$auto_scaling_only_enabled = false # --auto-scaling[=only]
	$from_cron_enabled = true # --from-cron

}

