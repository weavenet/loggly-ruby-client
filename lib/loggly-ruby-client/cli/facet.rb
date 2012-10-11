module LogglyRubyClient
  class CLI
    class Facet

      def facet
        opts = read_options
        @config = Config.new :domain   => opts[:domain],
                             :username => opts[:username],
                             :password => opts[:password]

        f = LogglyRubyClient::Facet.new :config => @config
        result = f.facet :input => opts[:input],
                         :from  => opts[:from],
                         :until => opts[:until],
                         :query => opts[:query]
        raise result.to_yaml
      end

      def read_options
        Trollop::options do
          version LogglyRubyClient::VERSION
          banner <<-EOS

Facet Loggly

Usage:

loggly-ruby-client facet -u username -p password -d domain -q query -i input -b facetby

EOS
          opt :help, "Display Help"
          opt :domain, "Account Domain", :type => :string
          opt :facetby, "Facet by ip, text or inputname", :type => :string
          opt :from, "From Date", :type => :string
          opt :until, "Until Date", :type  => :string,
                                    :short => :none
          opt :level, "Log Level", :type    => :string, 
                                   :default => 'info'
          opt :query, "Query", :type => :string
          opt :password, "Loggly Password", :type => :string
          opt :rows, "Rows To Return", :type => :string
          opt :username, "Loggly Username", :type => :string
        end
      end
 
    end
  end
end
