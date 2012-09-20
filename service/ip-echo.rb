#!/usr/bin/env ruby

# This is my homebrew what-is-my-ip service.
# Just put it on the server and let it run,
# when hit by a tcp connection it will echo the 
# connecting IP.

require 'socket'

server = TCPServer.new 3038

Signal.trap("INT") do
  puts "\nTerminating..."
  exit
end

loop do
  client = server.accept    # Wait for a client to connect
  client.puts client.peeraddr[-1]
  client.close
end
