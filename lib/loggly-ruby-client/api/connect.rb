module LogglyRubyClient
  class API
    class Connect

      def initialize(args)
        @config   = args[:config]
        @domain   = @config.domain
        @auth     = { :username => @config.username, 
                      :password => @config.password }
        @endpoint = "https://#{@domain}.loggly.com"
      end

      def run(cmd)
        HTTParty.get @endpoint + cmd, :basic_auth => @auth
      end

    end
  end
end
