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
        format_result result
      end

      private

      def format_result(result)
        body = result.response.body
        if result.response.code == "200"
          { 
            "body"  => JSON.parse(body),
            "code"  => result.response.code,
            "error" => ""
          }
        else
          { 
            "body"  => "",
            "code"  => result.response.code,
            "error" => body
          }
        end
      end
          
    end
  end
end
