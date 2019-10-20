# Class: cloudwatch
# =================
#
# ----------
# Authors: Salman Taherizadeh - Jozef Stefan Institute
#
# Copyright
# ----------
# 
# Main class defined for the module.
#
# It is meant to:
#     * install.pp --> Install the Amazon CloudWatch Agent
#     * config.pp --> Configure the Amazon CloudWatch Agent
#     * service.pp --> Run the Amazon CloudWatch Agent via the software utility "cron"
#
#
class cloudwatch () inherits cloudwatch::params {
  contain (::cloudwatch::install, ::cloudwatch::config, ::cloudwatch::service)
  Class['cloudwatch::install'] -> Class['cloudwatch::config'] -> Class['cloudwatch::service']
}

