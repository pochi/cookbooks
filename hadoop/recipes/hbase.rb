# coding: utf-8
# Written by @pochi_black
# Attention: rootで実行すること
# Reference: http://knowledgedonor.blogspot.com/2011/05/installing-cloudera-hadoop-hadoop-0202.html

Chef::Logger = :debug

script "Download the HBase" do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOC
  curl -O #{node[:hadoop][:cdh_hbase_download_url]}
EOC
  only_if { !File.exists?("/tmp/#{node[:hadoop][:cdh_hbase]}.tar.gz") }
end

script "tar -zxvf HBase" do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOC
  cp #{node[:hadoop][:cdh_hbase]}.tar.gz /opt/
  cd /opt
  tar -zxvf #{node[:hadoop][:cdh_hbase]}.tar.gz
  chown -R hadoop:staff /opt/#{node[:hadoop][:cdh_hbase]}
EOC

  only_if { !File.directory?("/opt/#{node[:hadoop][:cdh_hbase]}") }
end

cookbook_file "/opt/#{node[:hadoop][:cdh_hbase]}/conf/hbase-env.sh" do
  source "hbase-env.sh"
  owner "hadoop"
  group "staff"
  action :create
end

# TODO: nohup: can't detach from console: Inappropriate ioctl for deviceがでる
#       After set user hadoop using ssh, this script can work.
script "start hbase" do
  interpreter 'bash'
  user 'hadoop'
  cwd "/opt/#{node[:hadoop][:cdh_hbase]}"
  code <<-EOC
	export HADOOP_HOME=#{node[:hadoop][:hadoop_home]}
	export HBASE_HOME=#{node[:hadoop][:hbase_home]}
  export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home
  #{node[:hadoop][:hbase_home]}/bin/stop-hbase.sh
  #{node[:hadoop][:hbase_home]}/bin/start-hbase.sh
EOC
end
