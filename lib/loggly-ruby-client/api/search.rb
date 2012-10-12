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
        rows       = args[:rows]

        query      = build_query :query => args[:query],
                                 :input => args[:input]

        cmd << "q=#{query}&"
        cmd << "from=#{from_date}&" if from_date
        cmd << "rows=#{rows}&" if rows
        cmd << "until=#{until_date}&" if until_date

        connect.run cmd
      end

      private

      def build_query(args)
        query = args[:query]
        input = args[:input]

        string = ""
        string += query.join "%20AND%20"
        string += "%20AND%20" if query.any? && input.any?
        string += input.map { |i| "inputname:#{i}" }.join "%20OR%20"
      end

      def connect
        @connect ||= LogglyRubyClient::API::Connect.new :config => @config
      end

    end
  end
end
