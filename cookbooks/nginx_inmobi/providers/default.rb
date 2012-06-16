

action :stop do
  log "Stopping Nginx"
  service "nginx" do
    action :stop
    persist false
  end
end

action :start do
  log "Stopping Nginx"
  service "nginx" do
    action :start
    persist false
  end
end

action :restart do
  log " Restarting Nginx"
  action_stop
     sleep 5
  action_start
end

action :install do
  log " Running apt-get update"
  packages = new_resource.packages
  execute "update apt cache" do
    command "apt-get update"
    ignore_failure true
  end

  log "  Packages which will be installed: #{packages}"
  packages .each do |p|
    log "Installing package #{p}"
    package p do
      options "--force-yes"
      action :install
    end
  end
end

action :setup_config do
  log "Creating the symlink"
  not_if do (::File.exists?("/usr/share/perl/5.10")) end
  ::File.symlink("/usr/share/perl/5.10.1","/usr/share/perl/5.10")
#  if !File.symlink("/usr/share/perl/5.10")?
#    File.symlink("/usr/share/perl/5.10.1","/usr/share/perl/5.10")
#  end
  log "Done with perl synlink"
end
