module LogglyRubyClient
  class Config

    attr_accessor :domain, :password, :username

    def initialize(args ={})
      @account  = args[:account]
      load_config_file
      load_config

      @domain   = args[:domain] ? args[:domain] : @domain
      @username = args[:username] ? args[:username] : @username
      @password = args[:password] ? args[:password] : @password
    end

    private

    def load_config_file
      config_file = "#{ENV['HOME']}/.loggly-ruby-client.yml"

      if File.exists? config_file
        @config = YAML::load(File.open(config_file))
      else
        @config = {}
      end
    end

    def load_config
      ['username', 'password', 'domain'].each do |key|
        if @config.has_key? @account
          value = @config[@account].fetch key, nil
          self.send "#{key}=".to_sym, value
        else
          nil
        end
      end
    end

  end
end
