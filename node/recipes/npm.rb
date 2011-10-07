include_recipe "node::nvm"
include_recipe "node::node"

script "Install npm" do
  interpreter "bash"
  user "ITPUser"
  code <<-EOC
    source ~/.nvm/nvm.sh
    nvm use v0.4.12
    curl http://npmjs.org/install.sh | sh
  EOC
end

