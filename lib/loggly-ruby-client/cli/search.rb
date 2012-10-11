module LogglyRubyClient
  class CLI
    class Search

      def initialize
        @config          = Config.new
      end

      def search
        opts             = read_options
        @config.domain   = opts[:domain]
        @config.username = opts[:username]
        @config.password = opts[:password]

        search = LogglyRubyClient::Search.new :config => @config
        jj search.search :input => opts[:input],
                         :query => opts[:query]
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
          opt :domain, "Domain", :type => :string
          opt :from, "From Date", :type => :string
          opt :input, "Loggly Input", :type => :string
          opt :until, "Until Date", :type => :string
          opt :level, "Log Level", :type    => :string, 
                                   :default => 'info'
          opt :query, "Query", :type => :string
          opt :password, "Password", :type => :string
          opt :username, "Username", :type => :string
        end
      end
 
    end
  end
end
