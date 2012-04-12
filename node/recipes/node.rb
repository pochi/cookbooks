include_recipe "node::nvm"

script "Install node" do
  interpreter "bash"
  user "itp"
  code <<-EOC
    source ~/.nvm/nvm.sh
    nvm install v0.4.12
  EOC

  only_if { !systemu("source ~/.nvm/nvm.sh; node use v0.4.12; node -v").include?("v0.4.12") }
end

