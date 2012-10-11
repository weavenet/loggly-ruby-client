module LogglyRubyClient
  class API
    class Facet

      def initialize(args)
        @config   = args[:config]
        @auth     = { :username => @config.username, 
                      :password => @config.password }
        @domain   = @config.domain
        @endpoint = "https://#{@domain}.loggly.com"
      end

      def facet(args)
        cmd        = "#{@endpoint}/api/search?"
        input      = args[:input]
        query      = args[:query]
        from_date  = args[:from]
        until_date = args[:until]

        cmd << "from=#{from_date}&" if from_date
        cmd << "inputname=#{input}&" if input
        cmd << "q=#{query}&" if query
        cmd << "until=#{until_date}&" if until_date
        HTTParty.get cmd, :basic_auth => @auth
      end

    end
  end
end
