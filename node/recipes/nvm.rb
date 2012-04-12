Chef::Logger = :debug

script "Install nvm" do
  interpreter "bash"
  user "itp"
  code <<-EOC
    source ~/.bashrc
    git clone https://github.com/creationix/nvm.git
    cp -r nvm ~/.nvm
  EOC

  only_if { !File.directory?("/Users/ITPUser/.nvm") }
end

