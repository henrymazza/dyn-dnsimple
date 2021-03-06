class Settings
  attr_accessor :username, :password, :domain, :hostname, :update_frequency,
                :http_port, :current_ip, :errors

  def initialize(options = {})
    @config_file = File.join(APP_ROOT, 'config', 'config.yml')
    load(options)
    self.errors ||= {}
  end

  def clear
    self.instance_variables.each do |v|
      self.instance_variable_set v, nil
    end
    self.errors ||= {}
  end

  def save
    settings = {
      :username => self.username,
      :password => self.password,
      :domain => self.domain,
      :hostname => self.hostname,
      :update_frequency => self.update_frequency,
      :http_port => self.http_port,
      :current_ip => self.current_ip
    }

    unless File.exist? @config_file
      f = File.new(@config_file, "w")
      f.close
    end

    File.open(@config_file, "w") do |file|
      file.write settings.to_yaml
    end
    load
  end

  def load(options = {})
    settings = {
      :username => nil,
      :password => nil,
      :domain => nil,
      :hostname => nil,
      :update_frequency => 360,
      :http_port => 3333,
      :current_ip => nil
    }

    settings = YAML.load_file(@config_file) if File.exist? @config_file

    if options.any?
      # convert the keys to symbols
      options = options.inject({}){|option,(k,v)| option[k.to_sym] = v; option}
      settings = settings.merge(options)
    end

    self.username = settings[:username]
    self.password = settings[:password]
    self.domain   = settings[:domain]
    self.hostname = settings[:hostname]

    self.update_frequency = (settings[:update_frequency] && settings[:update_frequency] >= 360) ? settings[:update_frequency] : 360
    self.http_port = (settings[:http_port] && settings[:http_port] > 0) ? settings[:http_port] : 3333
    self.current_ip = (settings[:current_ip]) ? settings[:current_ip] : nil
  end

  def validate?(params)
    self.errors[:username] = "is required." if params[:username].nil? || params[:username].strip.empty?
    self.errors[:password] = "is required." if params[:password].nil? || params[:password].strip.empty?
    self.errors[:domain] = "is required." if params[:domain].nil? || params[:domain].empty?
    self.errors[:hostname] = "is required." if params[:hostname].nil? || params[:hostname].empty?
    self.errors.length == 0
  end
end

$settings = Settings.new
puts $settings.hostname
