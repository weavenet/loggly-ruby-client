module LogglyRubyClient
  class Search

    def initialize(args)
      @config = args[:config]
    end

    def search(args)
      api.search(args) 
    end

    private

    def api
      @api||= API.new :config => @config
    end

  end
end
