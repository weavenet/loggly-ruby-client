module LogglyRubyClient
  class API
    class Search

      def initialize(args)
        @config = args[:config]
      end

      def search
        response = HTTParty.get('http://twitter.com/statuses/public_timeline.json')
        puts response.body, response.code, response.message, response.headers.inspect
      end

    end
  end
end
