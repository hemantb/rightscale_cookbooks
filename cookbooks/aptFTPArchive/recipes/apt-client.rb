execute "apt-get update" do
        action    :nothing
end

template "/etc/apt/sources.list.d/inmobi-app-apt.list" do
  source "inmobi-app-apt.list.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/etc/apt/sources.list.d/tmpapt.list" do
  source "tmpapt.list.erb"
  owner "root"
  group "root"
  mode 0644
  notifies  :run, resources("execute[apt-get update]"), :immediately
end

log "Adding APT key for APPOps"
#execute "curl -s http://#{node[:aptFTPArchive][:aptserver]}/app-apt.key | apt-key add -" do
execute "curl -s http://appkg1.ev1.inmobi.com/app-apt.key | apt-key add -" do
  not_if "apt-key export 'app-ops'"
end.run_action(:run)

execute "curl -s http://appkg1.ev1.inmobi.com/inmobiglobal-apt.key | apt-key add -" do
  not_if "apt-key export 'InMobi Operations'"
end.run_action(:run)

log "Done APT key for APPOps"

log " Staring apt-get update"

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

log "Done with apt-get update"

