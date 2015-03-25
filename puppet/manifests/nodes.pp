
node basenode {
  
  require base
  
  include hadoop
  
}

node hadoop-master inherits basenode {
  
  include hadoop::namenode
  include hadoop::jobtracker
  
  include pig
  include hive
  
}

node /hadoop-slave\d+/ inherits basenode {
  
  include hadoop::datanode
  include hadoop::tasktracker

}