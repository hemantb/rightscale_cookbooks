rightscale_marker :begin

node[:nginx_inmobi][:nginxConfPackage] .each do |p|
  log "Installing #{p}"
  case "#{p}"
    when /(.*)[=|-](\d+.*)(\.deb|)$/
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

#  if (/(.*)=(.*)/.match("#{p}"))
   # log " Installing Package" + $1 "with version" + $2
#    package $1 do
#      version $2
#      action :install
#      options "--force-yes"
#    end
#  else
#    package p do
#      options "--force-yes"
#      action :install
#    end
#  end
#end

#case node[:nginx_inmobi][:restart]
#when "true"
#  log "stopping nginx"
#  nginx_inmobi "default" do
#    action :restart
#  end
#  log "started nginx"
#end

rightscale_marker :end
