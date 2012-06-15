action :install do
  log " Running apt-get update"
  execute "update apt cache" do
    command "apt-get update"
    ignore_failure true
  end
end

