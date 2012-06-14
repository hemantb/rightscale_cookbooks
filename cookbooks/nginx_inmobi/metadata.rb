maintainer       "InMobi"
maintainer_email "hemant.burman@inmobi.com"
license          "All rights reserved"
description      "Installs/Configures Nginx Johndoe and required server includes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "rightscale"

%w{ ubuntu }.each do |os|
  supports os
end
recipe  "nginx_inmobi::default", "Installs Nginx Johndoe"
recipe  "nginx_inmobi::debinst", "Installs Nginx server includes package"

attribute "nginx_inmobi/nginxConfPackage",
  :display_name => "Nginx Config Package",
  :description => "Nginx Conf With Version",
  :type => "string",
  :default => "nginx-config",
  :required => "recommended",
  :recipe => [ "nginx_inmobi::debinst" ]

attribute "nginx_inmobi/dir",
  :display_name => "Nginx Directory",
  :description => "Location of nginx configuration files",
  :default => "/opt/mkhoj/conf/nginx"

attribute "nginx_inmobi/user",
  :display_name => "Nginx User",
  :description => "User nginx will run as",
  :default => "nobody"

attribute "nginx_inmobi/binary",
  :display_name => "Nginx Binary",
  :description => "Location of the nginx server binary",
  :default => "/opt/mkhoj/sbin/nginx"

attribute "nginx_inmobi/gzip",
  :display_name => "Nginx Gzip",
  :description => "Whether gzip is enabled",
  :default => "on"

attribute "nginx_inmobi/gzip_comp_level",
  :display_name => "Nginx Gzip Compression Level",
  :description => "Amount of compression to use",
  :default => "2"

attribute "nginx_inmobi/gzip_proxied",
  :display_name => "Nginx Gzip Proxied",
  :description => "Whether gzip is proxied",
  :default => "any"

attribute "nginx_inmobi/gzip_types",
  :display_name => "Nginx Gzip Types",
  :description => "Supported MIME-types for gzip",
  :type => "array",
  :default => [ "text/plain", "text/html", "text/css", "application/x-javascript", "text/xml", "application/xml", "application/xml+rss", "text/javascript" ]

attribute "nginx_inmobi/worker_processes",
  :display_name => "Nginx Worker Processes",
  :description => "Number of worker processes",
  :default => "2"

attribute "nginx_inmobi/worker_connections",
  :display_name => "Nginx Worker Connections",
  :description => "Number of connections per worker",
  :default => "16384"

attribute "nginx_inmobi/keepalive",
  :display_name => "Nginx Keepalive",
  :description => "Whether to enable keepalive",
  :default => "on"

attribute "nginx_inmobi/keepalive_timeout",
  :display_name => "Nginx Keepalive Timeout",
  :default => "65"

attribute "nginx_inmobi/restart",
  :display_name => "Should nginx service be restarted? (eg: false ; default = true)",
  :description => "Mention if nginx service should be restarted. Use text value as true/false",
  :required => "optional",
  :default => "true",
  :recipes => [ "app_inmobi::debinst" ]
