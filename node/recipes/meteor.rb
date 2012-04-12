include_recipe "node::nvm"
include_recipe "node::node"

script "Install meteor" do
  interpreter "bash"
  user "itp"
  code <<-EOC
    source ~/.nvm/nvm.sh
    nvm use v0.4.12
    curl install.meteor.com | /bin/sh
  EOC
end

