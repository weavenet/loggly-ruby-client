module LogglyRubyClient
  class API
    class Search

      def initialize(args)
        @config   = args[:config]
        @domain   = @config.domain
        @password = @config.password
        @username = @config.username
        @endpoint = "https://#{@domain}.loggly.com"
      end

      def search(args)
        cmd   = "#{@endpoint}/api/search?"
        from  = args[:from]
        input = args[:input]
        query = args[:query]
        till  = args[:until]

        cmd << "from=#{from}&" if from
        cmd << "inputname=#{input}&" if input
        cmd << "q=#{query}&" if query
        cmd << "until=#{till}&" if till

        HTTParty.get cmd
      end

    end
  end
end
