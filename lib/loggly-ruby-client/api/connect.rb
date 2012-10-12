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
        result = HTTParty.get @endpoint + cmd, :basic_auth => @auth
        { :code => result.response.code,
          :body => JSON.parse(result.response.body) }
      end
          
    end
  end
end
