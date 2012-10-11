require 'json'
require 'trollop'

require 'loggly-ruby-client/cli/facet'
require 'loggly-ruby-client/cli/search'

module LogglyRubyClient
  class CLI
    def start
      cmd = ARGV.shift

      case cmd
      when 'facet'
        facet = LogglyRubyClient::CLI::Facet.new
        facet.facet
      when 'search'
        search = LogglyRubyClient::CLI::Search.new
        search.search
      when '-v'
        puts LogglyRubyClient::VERSION
      else
        puts "Unkown command: '#{cmd}'." unless cmd == '-h'
        puts "loggly-ruby-client [facet|search] OPTIONS"
        puts "Append -h for help on specific command."
      end
    end
  end
end
