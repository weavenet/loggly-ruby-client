module LogglyRubyClient
  class API
    class Search

      def initialize(args)
        @config  = args[:config]
      end

      def search(args)
        cmd        = "/api/search?"
        from_date  = args[:from]
        until_date = args[:until]
        query      = build_query :and_query => args[:and_query],
                                 :or_query  => args[:or_query],
                                 :input     => args[:input]

        cmd << "q=#{query}&"
        cmd << "from=#{from_date}&" if from_date
        cmd << "until=#{until_date}&" if until_date

        connect.run cmd
      end

      private

      def build_query(args)
        query = ""
        query += args[:and_query].join "%20AND%20"

        if query == ""
          query += args[:or_query].join "%20OR%20"
        else
          query += args[:or_query].map {|o| "%20OR%20#{o}"}.join
        end

        if query == ""
          query += args[:input].join "%20AND%20"
        else
          query += args[:input].map { |i| "%20AND%20#{i}" }.join
        end

      end

      def connect
        @connect ||= LogglyRubyClient::API::Connect.new :config => @config
      end

    end
  end
end
