# DevOps use case: Setup a Puppet module used to run the Amazon CloudWatch

NOTE: In order to proceed this guide, prior DevOps knowledge of working with the following technologies is highly required:

* Puppet configuration management tool
* Puppet declarative language for manifests
* Amazon CloudWatch
* Amazon EC2 cloud infrastructure

Amazon CloudWatch is a observability tool built for DevOps engineers, site reliability engineers, developers and IT managers. Amazon CloudWatch offers data insights useful to monitor cloud-based applications, respond to performance changes in the execution environment, optimise resource utilisation, and obtain a unified view of operational health at runtime. Amazon CloudWatch collects monitoring data in the form of metrics, logs and events, associated with different resources, applications, and services that run on AWS and on-premises servers. CloudWatch can be employed to detect anomalous behavior in the computing environment, set triggering alarms, visualise logs and metrics, take automated actions, troubleshooting operations, and discover helpful insights to keep services running smoothly.
<br><br>
This repository is about how to setup a Puppet module used to run the Amazon CloudWatch on whether AWS or on-premises servers. In other words, how to create a Puppet module to deploy a Monitoring Agent running on a Linux-based system regularly to push different metrics to the Amazon CloudWatch API.
<br>
![Image](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/images/CW-Overview.png)
<br>
Before you begin, make sure you have your own Puppet configuration management tool running. Moreover, we assume that you already have your credentials including the --aws-access-key-id and --aws-secret-key parameters. Otherwise, you must provide an IAM role. An IAM role is an identity that you can create in your account that has specific permissions. An IAM role is similar to an IAM user, but it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS. However, instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it. Also, a role does not have standard long-term credentials such as a password or access keys associated with it. Instead, when you assume a role, it provides you with temporary security credentials for your role session. 
<br><br>
If you do not know where to retrieve the --aws-access-key-id and --aws-secret-key parameters, after logging into your Amazon AWS console go to the following page and add a user: 
<br><br>https://console.aws.amazon.com/iam/home#/users
<br><br>
All your credentials or IAM role should be set in this file: [params.pp](https://github.com/salmant/DevOps-Puppet-Amazon-CloudWatch/blob/master/manifests/params.pp)
<br><br>
The params class contains all default parameters for our module. For example, cloudwatch_monitoring_scripts_folder which indicates the folder where you want to store the CloudWatch Monitoring Scripts. The default folder is "/cloudwatch-monitoring-scripts" that feel free to change it as you wish. 
<br><br>
The default monitoring interval is set to 1 minute. It should be noted that setting up an appropriate monitoring interval is necessary to ensure the reliability of the whole system, to
avoid overhead, and to prevent losing control over the running environment during auto-scaling actions. Therefore, I suggest you to choose the monitoring interval carefully. In this regard, you need also to take into accout the Amazon CloudWatch Pricing. You can get started with Amazon CloudWatch for free. 
<br><br>
According to the following Web page, the Amazon CloudWatch script is able to collect different metrics such as memory, swap and disk space utilisation on the current system. It then makes a remote call to the Amazon CloudWatch to report the measured data as custom metrics.
<br><br>


                           <table id="w317aac21c23b7c19b5">
                              
                              <tr>
                                 
                                 <th>Name</th>
                                 
                                 <th>Description</th>
                                 
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--mem-util </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Collects and sends the MemoryUtilization metrics in percentages. This metric
                                       counts memory allocated by applications and the operating system as used, and also
                                       includes cache
                                       and buffer memory as used if you specify the <code class="code">--mem-used-incl-cache-buff</code> option. 
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--mem-used </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p> Collects and sends the MemoryUsed metrics, reported in megabytes. This metric
                                       counts memory allocated by applications and the operating system as used, and also
                                       includes cache
                                       and buffer memory as used if you specify the <code class="code">--mem-used-incl-cache-buff</code> option.
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--mem-used-incl-cache-buff </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>If you include this option, memory currently used for  cache and buffers is counted
                                       as "used" when the metrics are reported for <code class="code">--mem-util</code>, 
                                       <code class="code">--mem-used</code>, and <code class="code">--mem-avail</code>.
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--mem-avail </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p> Collects and sends the MemoryAvailable metrics, reported in megabytes. This metric
                                       counts memory allocated by applications and the operating system as used, and also
                                       includes cache
                                       and buffer memory as used if you specify the <code class="code">--mem-used-incl-cache-buff</code> option.
                                       
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--swap-util </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p> Collects and sends SwapUtilization metrics, reported in percentages.
                                       
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--swap-used </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p> Collects and sends SwapUsed metrics, reported in megabytes. </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--disk-path=PATH </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p> Selects the disk on which to report. </p>
                                    
                                    <p>PATH can specify a mount point or any file located on a mount point for the
                                       filesystem that needs to be reported. For selecting multiple disks, specify a
                                       <code class="code">--disk-path=PATH</code> for each one of them. 
                                    </p>
                                    
                                    <p> To select a disk for the filesystems mounted on <code class="code">/</code> and
                                       <code class="code">/home</code>, use the following parameters: 
                                    </p>
                                    
                                    <p><code class="code">--disk-path=/ --disk-path=/home</code></p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--disk-space-util</code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Collects and sends the DiskSpaceUtilization metric for the selected disks.
                                       The metric is reported in percentages.
                                    </p>
                                    
                                    <p>Note that the disk utilization metrics calculated by this script differ from
                                       the values calculated by the df -k -l command. If you find the values from df -k -l
                                       more useful, you can change the calculations in the script.
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--disk-space-used</code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Collects and sends the DiskSpaceUsed metric for the selected disks. The
                                       metric is reported by default in gigabytes. 
                                    </p>
                                    
                                    <p> Due to reserved disk space in Linux operating systems, disk space used and
                                       disk space available might not accurately add up to the amount of total disk space.
                                       
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--disk-space-avail </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Collects and sends the DiskSpaceAvailable metric for the selected disks. The
                                       metric is reported in gigabytes. 
                                    </p>
                                    
                                    <p> Due to reserved disk space in the Linux operating systems, disk space used
                                       and disk space available might not accurately add up to the amount of total disk
                                       space. 
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--memory-units=UNITS </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Specifies units in which to report memory usage. If not specified, memory is
                                       reported in megabytes. UNITS may be one of the following: bytes, kilobytes,
                                       megabytes, gigabytes. 
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--disk-space-units=UNITS
                                          </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Specifies units in which to report disk space usage. If not specified, disk
                                       space is reported in gigabytes. UNITS may be one of the following: bytes, kilobytes,
                                       megabytes, gigabytes. 
                                    </p>
                                    
                                 </td>
                                 
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--aws-credential- file=PATH
                                          </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Provides the location of the file containing AWS credentials. </p>
                                    
                                    <p>This parameter cannot be used with the <code class="code">--aws-access-key-id</code> and
                                       -<code class="code">-aws-secret-key</code> parameters. 
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--aws-access-key-id=VALUE
                                          </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Specifies the AWS access key ID to use to identify the caller. Must be used
                                       together with the <code class="code">--aws-secret-key</code> option. Do not use this option with
                                       the <code class="code">--aws-credential-file</code> parameter. 
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--aws-secret-key=VALUE </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Specifies the AWS secret access key to use to sign the request to CloudWatch.
                                       Must be used together with the <code class="code">--aws-access-key-id</code> option. Do not use
                                       this option with <code class="code">--aws-credential-file</code> parameter.
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--aws-iam-role=VALUE</code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Specifies the IAM role used to provide AWS credentials. The value
                                       <code class="code">=VALUE</code> is required. If no credentials are specified, the default IAM
                                       role associated with the EC2 instance is applied. Only one IAM role can be used. If
                                       no IAM roles are found, or if more than one IAM role is found, the script will
                                       return an error.
                                    </p>
                                    
                                    <p>Do not use this option with the <code class="code">--aws-credential-file</code>,
                                       <code class="code">--aws-access-key-id</code>, or <code class="code">--aws-secret-key</code>
                                       parameters.
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--aggregated[=only]</code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Adds aggregated metrics for instance type, AMI ID, and overall for the
                                       region. The value <code class="code">=only</code> is optional; if specified, the script reports
                                       only aggregated metrics.
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--auto-scaling[=only]</code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Adds aggregated metrics for the Auto Scaling group. The value
                                       <code class="code">=only</code> is optional; if specified, the script reports only Auto Scaling
                                       metrics. The <a href="https://docs.aws.amazon.com/IAM/latest/UserGuide/ManagingPolicies.html">IAM policy</a>
                                       associated with the IAM account or role using the scripts need to have permissions
                                       to call the EC2 action <a href="https://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-DescribeTags.html">DescribeTags</a>.
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--verify </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Performs a test run of the script that collects the metrics, prepares a
                                       complete HTTP request, but does not actually call CloudWatch to report the data.
                                       This option also checks that credentials are provided. When run in verbose mode,
                                       this option outputs the metrics that will be sent to CloudWatch. 
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--from-cron </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Use this option when calling the script from cron. When this option is used,
                                       all diagnostic output is suppressed, but error messages are sent to the local system
                                       log of the user account. 
                                    </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--verbose </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Displays detailed information about what the script is doing. </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--help </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Displays usage information. </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                              <tr>
                                 
                                 <td>
                                    
                                    <p>
                                       <code class="code">--version </code>
                                       
                                    </p>
                                    
                                 </td>
                                 
                                 <td>
                                    
                                    <p>Displays the version number of the script. </p>
                                    
                                 </td>
                                 
                              </tr>
                              
                           </table>









