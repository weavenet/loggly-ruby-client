require 'spec_helper'
require 'loggly-ruby-client/cli'

describe LogglyRubyClient::CLI do
  it "should call the search method when search subcmd given" do
    ARGV.stub :shift => 'search'
    search_mock = mock 'search'
    LogglyRubyClient::CLI::Search.stub :new => search_mock
    search_mock.should_receive(:search)
    cli = LogglyRubyClient::CLI.new
    cli.start
  end
end
