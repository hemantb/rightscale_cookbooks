rightscale_marker :begin

node[:nginx_inmobi][:nginxConfPackage] .each do |p|
  log "Installing #{p}"
  case "#{p}"
    when /(.*?)[=|-](\d+.*?)(\.deb|)$/
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

rightscale_marker :end
