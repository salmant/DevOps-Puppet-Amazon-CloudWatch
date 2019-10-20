# DevOps use case: Setup a Puppet module used to install, configure and run the Amazon CloudWatch

NOTE: In order to proceed this guide, prior DevOps knowledge of working with the following technologies is highly required:

* Puppet configuration management tool
* Puppet declarative language for manifests
* Amazon CloudWatch
* Amazon EC2 cloud infrastructure

Amazon CloudWatch is a observability tool built for DevOps engineers, site reliability engineers, developers and IT managers. Amazon CloudWatch offers data insights useful to monitor cloud-based applications, respond to performance changes in the execution environment, optimise resource utilisation, and obtain a unified view of operational health at runtime. Amazon CloudWatch collects monitoring data in the form of metrics, logs and events, associated with different resources, applications, and services that run on AWS and on-premises servers. CloudWatch can be employed to detect anomalous behavior in the computing environment, set triggering alarms, visualise logs and metrics, take automated actions, troubleshooting operations, and discover helpful insights to keep services running smoothly.
<br><br>
This repository is about how to setup a Puppet module used to run the Amazon CloudWatch on whether AWS or on-premises servers. In other words, how to create a Puppet module to deploy a Monitoring Agent running on a Linux-based system regularly to push different metrics to the Amazon CloudWatch API.
<br><br>
![Image](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/images/CW-Overview.png)
<br><br>
Before you begin, make sure you have your own Puppet configuration management tool running. Moreover, we assume that you already have your credentials including the `--aws-access-key-id` and `--aws-secret-key parameters`. Otherwise, you must provide an IAM role. An IAM role is an identity that you can create in your account that has specific permissions. An IAM role is similar to an IAM user, but it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS. However, instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it. Also, a role does not have standard long-term credentials such as a password or access keys associated with it. Instead, when you assume a role, it provides you with temporary security credentials for your role session. 
<br><br>
If you do not know where to retrieve the `--aws-access-key-id` and `--aws-secret-key` parameters, after logging into your Amazon AWS console go to the following page and add a user: 
<br><br>https://console.aws.amazon.com/iam/home#/users
<br><br>
Your credentials or IAM role should be set in this file: [params.pp](https://github.com/salmant/DevOps-Puppet-Amazon-CloudWatch/blob/master/manifests/params.pp)
<br><br>
The `params` class contains all default parameters for our module. For example, the variable named `cloudwatch_monitoring_scripts_folder` indicates the folder where you want to store the CloudWatch Monitoring Scripts. The default folder is `/cloudwatch-monitoring-scripts` and feel free to change it as you wish. 
<br><br>
The default monitoring interval named `monitoring_interval_minutes` is set to 1 minute. It should be noted that setting up an appropriate monitoring interval is necessary to ensure the reliability of the whole system, to avoid overhead, and to prevent losing control over the running environment during auto-scaling actions. Therefore, I suggest you to choose the monitoring interval carefully. In this regard, you need also to take into accout the Amazon CloudWatch Pricing. You can get started with Amazon CloudWatch for free. 
<br><br>
According to the following Web page, the Amazon CloudWatch script is able to collect different metrics such as memory, swap and disk space utilisation on the current system. It then makes a remote call to the Amazon CloudWatch to report the measured data as custom metrics.
<br><br>
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html
<br>
<table id='w317aac21c23b7c19b5'>

<tbody>

<tr>

<th>Name</th>

<th>Description</th>

</tr>

<tr>

<td>--mem-util</td>

<td>Collects and sends the MemoryUtilization metrics in percentages. This metric counts memory allocated by applications and the operating system as used, and also includes cache and buffer memory as used if you specify the `--mem-used-incl-cache-buff` option.</td>

</tr>

<tr>

<td>--mem-used</td>

<td>Collects and sends the MemoryUsed metrics, reported in megabytes. This metric counts memory allocated by applications and the operating system as used, and also includes cache and buffer memory as used if you specify the `--mem-used-incl-cache-buff` option.</td>

</tr>

<tr>

<td>--mem-used-incl-cache-buff</td>

<td>If you include this option, memory currently used for cache and buffers is counted as "used" when the metrics are reported for `--mem-util`, `--mem-used`, and `--mem-avail`.</td>

</tr>

<tr>

<td>--mem-avail</td>

<td>Collects and sends the MemoryAvailable metrics, reported in megabytes. This metric counts memory allocated by applications and the operating system as used, and also includes cache and buffer memory as used if you specify the `--mem-used-incl-cache-buff` option.</td>

</tr>

<tr>

<td>--swap-util</td>

<td>Collects and sends SwapUtilization metrics, reported in percentages.</td>

</tr>

<tr>

<td>--swap-used</td>

<td>Collects and sends SwapUsed metrics, reported in megabytes.</td>

</tr>

<tr>

<td>--disk-path=PATH</td>

<td>Selects the disk on which to report. PATH can specify a mount point or any file located on a mount point for the filesystem that needs to be reported. For selecting multiple disks, specify a `--disk-path=PATH` for each one of them. To select a disk for the filesystems mounted on `/` and `/home`, use the following parameters: `--disk-path=/ --disk-path=/home`</td>

</tr>

<tr>

<td>--disk-space-util</td>

<td>Collects and sends the DiskSpaceUtilization metric for the selected disks. The metric is reported in percentages. Note that the disk utilization metrics calculated by this script differ from the values calculated by the df -k -l command. If you find the values from df -k -l more useful, you can change the calculations in the script.</td>

</tr>

<tr>

<td>--disk-space-used</td>

<td>Collects and sends the DiskSpaceUsed metric for the selected disks. The metric is reported by default in gigabytes. Due to reserved disk space in Linux operating systems, disk space used and disk space available might not accurately add up to the amount of total disk space.</td>

</tr>

<tr>

<td>--disk-space-avail</td>

<td>Collects and sends the DiskSpaceAvailable metric for the selected disks. The metric is reported in gigabytes. Due to reserved disk space in the Linux operating systems, disk space used and disk space available might not accurately add up to the amount of total disk space.</td>

</tr>

<tr>

<td>--memory-units=UNITS</td>

<td>Specifies units in which to report memory usage. If not specified, memory is reported in megabytes. UNITS may be one of the following: bytes, kilobytes, megabytes, gigabytes.</td>

</tr>

<tr>

<td>--disk-space-units=UNITS</td>

<td>Specifies units in which to report disk space usage. If not specified, disk space is reported in gigabytes. UNITS may be one of the following: bytes, kilobytes, megabytes, gigabytes.</td>

</tr>

<tr>

<td>--aws-credential- file=PATH</td>

<td>Provides the location of the file containing AWS credentials. This parameter cannot be used with the `--aws-access-key-id` and -`-aws-secret-key` parameters.</td>

</tr>

<tr>

<td>--aws-access-key-id=VALUE</td>

<td>Specifies the AWS access key ID to use to identify the caller. Must be used together with the `--aws-secret-key` option. Do not use this option with the `--aws-credential-file` parameter.</td>

</tr>

<tr>

<td>--aws-secret-key=VALUE</td>

<td>Specifies the AWS secret access key to use to sign the request to CloudWatch. Must be used together with the `--aws-access-key-id` option. Do not use this option with `--aws-credential-file` parameter.</td>

</tr>

<tr>

<td>--aws-iam-role=VALUE</td>

<td>Specifies the IAM role used to provide AWS credentials. The value `=VALUE` is required. If no credentials are specified, the default IAM role associated with the EC2 instance is applied. Only one IAM role can be used. If no IAM roles are found, or if more than one IAM role is found, the script will return an error. Do not use this option with the `--aws-credential-file`, `--aws-access-key-id`, or `--aws-secret-key` parameters.</td>

</tr>

<tr>

<td>--aggregated[=only]</td>

<td>Adds aggregated metrics for instance type, AMI ID, and overall for the region. The value `=only` is optional; if specified, the script reports only aggregated metrics.</td>

</tr>

<tr>

<td>--auto-scaling[=only]</td>

<td>Adds aggregated metrics for the Auto Scaling group. The value `=only` is optional; if specified, the script reports only Auto Scaling metrics. The IAM policy associated with the IAM account or role using the scripts need to have permissions to call the EC2 action DescribeTags.</td>

</tr>

<tr>

<td>--from-cron</td>

<td>Use this option when calling the script from cron. When this option is used, all diagnostic output is suppressed, but error messages are sent to the local system log of the user account.</td>

</tr>

<tr>

</tbody>

</table>

<br>
<br>

In the `params` class, you can specify which metrics are required to be monitored and reported. If you would like to have a certain metric measured, use `true`. Otherwise, you need to determin the value of `false` for the metric.
<br><br>
The entry point to our module is this file: [init.pp](https://github.com/salmant/DevOps-Puppet-Amazon-CloudWatch/blob/master/manifests/init.pp)
<br><br>
The Amazon CloudWatch installation step of our Puppet module is written in this file: [install.pp](https://github.com/salmant/DevOps-Puppet-Amazon-CloudWatch/blob/master/manifests/install.pp)
<br><br>
The Amazon CloudWatch configure step of our Puppet module is written in this file: [config.pp](https://github.com/salmant/DevOps-Puppet-Amazon-CloudWatch/blob/master/manifests/config.pp)
<br><br>
The final part of our module is to run the Amazon CloudWatch Agent that is written in this file: [service.pp](https://github.com/salmant/DevOps-Puppet-Amazon-CloudWatch/blob/master/manifests/service.pp)
<br><br>

