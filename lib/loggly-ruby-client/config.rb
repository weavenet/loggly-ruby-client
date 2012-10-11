module LogglyRubyClient
  class Config

    attr_accessor :domain, :password, :username

    def initialize(args = {})
      @domain   = args[:domain]
      @username = args[:username]
      @password = args[:password]
    end

  end
end

