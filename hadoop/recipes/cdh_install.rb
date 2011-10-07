# coding: utf-8
# Written by @pochi_black
# Attention: rootで実行すること
# Reference: http://knowledgedonor.blogspot.com/2011/05/installing-cloudera-hadoop-hadoop-0202.html

Chef::Logger = :debug

script "Download the hadoop" do
  interpreter 'bash'
  user 'hadoop'
  cwd '/tmp'
  code <<-EOC
  curl -O #{node[:hadoop][:cdh_hadoop_download_url]}
EOC
  only_if { !File.exists?("/opt/#{node[:hadoop][:cdh_hadoop]}.tar.gz") }
end

script "tar -zxvf hadoop" do
  interpreter 'bash'
  user 'hadoop'
  cwd '/tmp'
  code <<-EOC
  cp #{node[:hadoop][:cdh_hadoop]}.tar.gz /opt/
  cd /opt
  tar -zxvf #{node[:hadoop][:cdh_hadoop]}.tar.gz
EOC

  only_if { !File.directory?("/opt/#{node[:hadoop][:cdh_hadoop]}") }
end

script "prepare hadoop dir" do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOC
  mkdir hadoop
  chown -R hadoop hadoop
EOC

  only_if { !File.directory?("/tmp/hadoop") }
end

["hdfs-site.xml", "core-site.xml", "mapred-site.xml"].each do |override_file|
  cookbook_file "/opt/#{node[:hadoop][:cdh_hadoop]}/conf/#{override_file}" do
    source override_file
    owner "hadoop"
    group "staff"
    action :create
  end
end

# TODO: Not working.
#       After set user hadoop using ssh, this script can work.
script "initialize namenode && start hadoop" do
  interpreter 'bash'
  user 'hadoop'
  cwd "/opt/#{node[:hadoop][:cdh_hadoop]}"
  code <<-EOC
  export HADOOP_HOME=/opt/#{node[:hadoop][:cdh_hadoop]}
  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
  ./bin/hadoop namenode --format  
  ./bin/stop-all.sh
  ./bin/start-all.sh
EOC
end

