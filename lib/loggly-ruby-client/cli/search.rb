module LogglyRubyClient
  class CLI
    class Search

      def search
        opts = read_options
        @config = Config.new :domain   => opts[:domain],
                             :username => opts[:username],
                             :password => opts[:password]

        s = LogglyRubyClient::Search.new :config => @config
        result = s.search :input => opts[:input],
                          :from  => opts[:from],
                          :until => opts[:until],
                          :query => opts[:query]

        if result.response.code == "200"
          puts result.response.body
        else
          puts "Error: #{result}"
          exit 1
        end
      end

      def read_options
        Trollop::options do
          version LogglyRubyClient::VERSION
          banner <<-EOS

Search Loggly

Usage:

loggly-ruby-client search -u username -p password -d domain -q query -i input

EOS
          opt :help, "Display Help"
          opt :domain, "Account Domain", :type => :string
          opt :from, "From Date", :type => :string
          opt :input, "Input To Search", :type  => :string,
                                         :multi => true
          opt :until, "Until Date", :type  => :string,
                                    :short => :none
          opt :level, "Log Level", :type    => :string, 
                                   :default => 'info'
          opt :query, "Query (multiple will be joined with AND)", :type  => :string,
                                                                  :multi => true
          opt :password, "Loggly Password", :type => :string
          opt :rows, "Rows To Return", :type => :string
          opt :username, "Loggly Username", :type => :string
        end
      end
 
    end
  end
end
