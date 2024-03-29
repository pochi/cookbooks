default.hadoop[:cdh_hadoop_download_url] = %q(http://archive.cloudera.com/cdh/3/hadoop-0.20.2-cdh3u1.tar.gz)
default.hadoop[:cdh_hbase_download_url] = %q(http://archive.cloudera.com/cdh/3/hbase-0.90.3-cdh3u1.tar.gz)
default.hadoop[:cdh_hbase] = default.hadoop[:cdh_hbase_download_url].split("/").last.sub(".tar.gz", "")
default.hadoop[:cdh_hadoop] = default.hadoop[:cdh_hadoop_download_url].split("/").last.sub(".tar.gz", "")
default.hadoop[:hadoop_home] = File.join("/opt", default.hadoop[:cdh_hadoop])
default.hadoop[:hbase_home] = File.join("/opt", default.hadoop[:cdh_hbase])
