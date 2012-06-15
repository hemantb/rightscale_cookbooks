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
end

log "Adding APT key for APPOps"
#execute "curl -s http://#{node[:aptFTPArchive][:aptserver]}/app-apt.key | apt-key add -" do
execute "curl -s http://appkg1.ev1.inmobi.com/app-apt.key | apt-key add -" do
  not_if "apt-key export 'app-ops'"
end.run_action(:run)

execute "curl -s http://appkg1.ev1.inmobi.com/inmobiglobal-apt.key | apt-key add -" do
  not_if "apt-key export 'InMobi Operations'"
end.run_action(:run)


apt_repository "inmobi-app-apt" do
  uri "http://#{node[:aptFTPArchive][:aptserver]}/deb/inmobi/"
  distribution "prod"
  components ["main","ops","3pp","3ppours"]
#  keyserver "keyserver.ubuntu.com"
#  key "C0061A4A"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

apt_repository "pkg_ua2-apt" do
  uri "http://pkg.ua2.inmobi.com:9999/deb/inmobi/"
  distribution "prod"
  components ["main","ops","3pp","3ppours"]
#  keyserver "keyserver.ubuntu.com"
#  key "C0061A4A"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

apt_repository "pkg_ev1-apt" do
  uri "http://pkg.ev1.inmobi.com:9999/apt/inmobi/"
  distribution "testing"
  components ["main"]
#  keyserver "keyserver.ubuntu.com"
#  key "C0061A4A"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

log "Done APT key for APPOps"

log " Staring apt-get update"

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end.run_action(:run)

log "Done with apt-get update"

