require 'socket'

class DynDNSimple
  def self.refresh!
    return unless refreshable?

    DNSimple::Client.username = $settings.username
    DNSimple::Client.password = $settings.password

    s = TCPSocket.new 'sampa2.officina.me', 3038
    $settings.current_ip = s.gets
    s.close

    $log.info "DynDNSimple: Current External IP is #{$settings.current_ip}"
    update_record
  end

  def self.refreshable?
    !$settings.username.nil? &&
    !$settings.password.nil? &&
    !$settings.domain.nil? &&
    !$settings.hostname.nil?
  end

  def self.update_record
    domain = DNSimple::Domain.find($settings.domain)
    records = DNSimple::Record.all(domain)

    record = records.detect{|r| need_to_update?(r) }
    return unless record

    record.content = $settings.current_ip
    record.save
    $log.info "DynDNSimple: New External IP is #{record.content}"
  end

  def self.need_to_update?(record)
    record.name == $settings.hostname &&
    record.record_type == "A" &&
    record.content != $settings.current_ip
  end
end
