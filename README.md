# DevOps use case: Setup a Puppet module used to run the Amazon CloudWatch

NOTE: In order to proceed this guide, prior DevOps knowledge of working with the following technologies is highly required:

Puppet configuration management tool
Puppet declarative language for manifests
Amazon CloudWatch
Amazon EC2 cloud infrastructure

Amazon CloudWatch is a observability tool built for DevOps engineers, site reliability engineers, developers and IT managers. Amazon CloudWatch offers data insights useful to monitor cloud-based applications, respond to performance changes in the execution environment, optimise resource utilisation, and obtain a unified view of operational health at runtime. Amazon CloudWatch collects monitoring data in the form of metrics, logs and events, associated with different resources, applications, and services that run on AWS and on-premises servers. CloudWatch can be employed to detect anomalous behavior in the computing environment, set triggering alarms, visualise logs and metrics, take automated actions, troubleshooting operations, and discover helpful insights to keep services running smoothly.
<br><br>
This repository is about how to setup a Puppet module used to run the Amazon CloudWatch on whether AWS or on-premises servers. In other words, how to create a Puppet module to deploy a Monitoring Agent running on a Linux-based system regularly to push different metrics to the Amazon CloudWatch API.
<br>
![Image](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/images/CW-Overview.png)
<br>
Before you begin, make sure you have your own Puppet configuration management tool running. Moreover, we assume that you already have your credentials including the --aws-access-key-id and --aws-secret-key parameters. Otherwise, you must provide an IAM role. An IAM role is an identity that you can create in your account that has specific permissions. An IAM role is similar to an IAM user, but it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS. However, instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it. Also, a role does not have standard long-term credentials such as a password or access keys associated with it. Instead, when you assume a role, it provides you with temporary security credentials for your role session. 
<br>
If you do not know where to retrieve the --aws-access-key-id and --aws-secret-key parameters, after logging into your Amazon AWS console go to the following page and add a user: 
<br>https://console.aws.amazon.com/iam/home#/users
<br>
All your credentials or IAM role should be set in this file: [params.pp](https://github.com/salmant/DevOps-Puppet-Amazon-CloudWatch/blob/master/manifests/params.pp)
<br>
The params class contains all default parameters for our module. For example, cloudwatch_monitoring_scripts_folder which indicates the folder where you want to store the CloudWatch Monitoring Scripts. The default folder is "/cloudwatch-monitoring-scripts" that feel free to change it as you wish. 
<br>
The default monitoring interval is set to 1 minute. It should be noted that setting up an appropriate monitoring interval is necessary to ensure the reliability of the whole system, to
avoid overhead, and to prevent losing control over the running environment during auto-scaling actions. Therefore, I suggest you to choose the monitoring interval carefully. In this regard, you need also to take into accout the Amazon CloudWatch Pricing. You can get started with Amazon CloudWatch for free. 
<br>
According to the following Web page, the Amazon CloudWatch script is able to collect different metrics such as memory, swap and disk space utilisation on the current system. It then makes a remote call to the Amazon CloudWatch to report the measured data as custom metrics.











