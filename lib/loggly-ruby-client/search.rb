module LogglyRubyClient
  class Search

    def initialize(args)
      @config = Config.new :domain      => args[:domain],
                           :config_file => args[:config_file],
                           :username    => args[:username],
                           :password    => args[:password],
                           :account     => args[:account]
    end

    def search(args)
      api.search(args) 
    end

    private

    def api
      @api ||= API.new :config => @config
    end

  end
end
