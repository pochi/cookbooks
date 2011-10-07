Chef::Logger = :debug

HADOOP_DOWNLOAD_URL = %q(http://www.meisei-u.ac.jp/mirror/apache/dist//hadoop/common/hadoop-0.20.203.0/hadoop-0.20.203.0rc1.tar.gz)
HADOOP = %q(hadoop-0.20.203.0rc1.tar.gz)

script "Get hadoop" do
  interpreter 'bash'
  user 'ITPUser'
  cwd '/tmp'
  code <<-EOC
  curl -O #{HADOOP_DOWNLOAD_URL}
EOC
end

script "tar -zxvf hadoop" do
  interpreter 'bash'
  user 'ITPUser'
  cwd '/tmp'
  code <<-EOC
  cp #{HADOOP} /opt/
  cd /opt
  tar -zxvf #{HADOOP}
EOC
end

def hadoop_is_installed?
  true
end
