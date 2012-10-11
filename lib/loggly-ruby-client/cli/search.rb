module LogglyRubyClient
  class CLI
    class Search
      def search
        search = LogglyRubyClient::Search.new
        search.search
      end
    end
  end
end
