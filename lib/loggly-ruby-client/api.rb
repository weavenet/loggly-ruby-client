require 'httparty'
require 'loggly-ruby-client/api/search'

module LogglyRubyClient

  class API

    def initialize(args)
      @config = args[:config]
    end

    def search(args)
      api_search.search args
    end

    private
    
    def api_search
      @api_search ||= API::Search.new :config => @config
    end

    def facet
      @api_facet ||= API::Facet.new :config => @config
    end

  end
end
