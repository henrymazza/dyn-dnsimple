require 'dnsimple'

DNSimple::Client.username   = 'fabio.mazarotto@me.com'
DNSimple::Client.password   = 'nsxf969'

user = DNSimple::User.me
puts "#{user.domain_count} domains"

puts "Domains..."
DNSimple::Domain.all.each do |domain|
  puts "  #{domain.name}"
end

domain = DNSimple::Domain.find("akivest.com.br")
puts DNSimple::Record.all(domain).detect{|r|
  r.name == 'cameras' &&
  r.record_type == 'A'
}.inspect

