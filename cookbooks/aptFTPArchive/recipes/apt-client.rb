template "/etc/apt/sources.list.d/inmobi-app-apt.list" do
  source "inmobi-app-apt.list.erb"
  owner "root"
  group "root"
  mode 0644
end

execute "curl -s http://#{node[:aptFTPArchive][:aptserver]/app-apt.key | apt-key add -" do
  not_if "apt-key export 'InMobi Operations (InMobi)'"
end
