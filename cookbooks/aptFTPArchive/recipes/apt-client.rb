template "/etc/apt/sources.list.d/inmobi-app-apt.list" do
  source "inmobi-app-apt.list.erb"
  owner "root"
  group "root"
  mode 0644
end

#execute "curl -s http://#{node[:aptFTPArchive][:aptserver]}/app-apt.key | apt-key add -" do
execute "curl -s http://appkg1.ev1.inmobi.com/app-apt.key | apt-key add -" do
  not_if "apt-key export 'InMobi Operations (InMobi)'"
end.run_action(:run)


log " Staring apt-get update"

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

log "Done with apt-get update"

