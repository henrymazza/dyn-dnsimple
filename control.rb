require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('dyn-dnsimple.rb', {:dir_mode => :normal, :dir => "/tmp/dyn-dnsimple.pid"}) do
  Dir.chdir(pwd)
  exec "ruby dyn-dnsimple.rb"
end
  
