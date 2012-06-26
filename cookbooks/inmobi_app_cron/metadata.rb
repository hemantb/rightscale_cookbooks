maintainer       "InMobi Technologies Pvt Ltd"
maintainer_email "hemant.burman@inmobi.com"
license          "All rights reserved"
description      "Install app_package for cron if tag not present inmobi_app_cron"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "rightscale"

recipe "inmobi_app_cron::default" , "Installs crons only if the tage provided is missing"

attribute "inmobi_app_cron/debians",
  :display_name => "Give space separated list of pkg1=version1,pkg2=version2,... entries",
  :description => "If version number is omitted packagename with latest version will be installed",
  :required => true,
  :recipes => [ "inmobi_app_cron::default" ]

attribute "inmobi_app_cron/app_name",
  :display_name => "Mention the identifier for the application name that this cron package is being used for",
  :required => true,
  :recipes => [
    "inmobi_app_cron::default",
  ]


