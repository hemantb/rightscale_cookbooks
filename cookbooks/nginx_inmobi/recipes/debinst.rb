rs_utils_marker :begin

node[:nginx_inmobi][:nginxConfPackage] .each do |p|
  log "Installing #{p}"
  if ( "#{p}" =~ (.*?)=(.*)
  if (/(\w+)==(.*)/.match("#{p}"))
    log " Installing Package" + $1 "with version" + $2
    package $1 do
      version $2
      action :install
      options "--force-yes"
    end
  else
    package p do
      options "--force-yes"
      action :install
    end
  end
end

case node[:nginx_inmobi][:restart]
when "true"
  nginx_config "default" do
    action :restart
  end
end

rs_utils_marker :end
