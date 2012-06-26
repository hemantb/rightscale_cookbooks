#
# Cookbook Name:: inmobi_app_cron
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

class Chef::Recipe
  include Inmobi::Cron::Helper
end

cron_servers = get_cron_servers(node[:inmobi_app_cron][:app_name])

if cron_servers.length >= 1
	cron_servers.each_key do |id|
		log "There is already another host #{cron_servers["#{id}"][:ip]} running the cron"
		#throw "there is already another host with this cron"
		exit()
	end
else


debians = node[:inmobi_app_cron][:debians]

debians.gsub(/\s+/, "").split(",").uniq.each do |p|
  log "Installing #{p}"
  case "#{p}"
    when /(.*?)[=|-](\d+.*?)(\.deb|)$/
      package $1 do
        version $2
        options "--force-yes"
      end
    else
      package p do
        options "--force-yes"
      end
    end
  end


include_recipe "rightscale::setup_server_tags"

#Setup Tags
right_link_tag "inmobi_cron:#{node[:inmobi_app_cron][:app_name]}=true"
right_link_tag "inmobi_cron:addr_ip=#{node[:app][:ip]}"

end

rightscale_marker :end
