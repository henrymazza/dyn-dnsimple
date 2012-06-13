require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run(File.join(File.dirname(__FILE__), 'dyn-dnsimple.rb'),{
  :dir_mode   => :normal,
  :dir        => File.join(File.dirname(__FILE__), "tmp/pids"),
  :app_name   => "dyn-dnsimple",
  :backtrace  => true,
  :log_output => true,
  :monitor    => true
})
