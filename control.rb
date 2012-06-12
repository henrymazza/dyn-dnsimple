require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run('/home/fabio/dyn-dnsimple/dyn-dnsimple.rb', {:dir_mode => :normal, :dir => "/home/fabio/dyn-dnsimple/tmp/pids"}) 
  
