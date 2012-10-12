require 'spec_helper'
require 'loggly-ruby-client/cli'

describe LogglyRubyClient::CLI::Search do

  before do
    @options = { :query    => 'query',
                 :from     => 'from',
                 :until    => 'until',
                 :rows     => 'rows',
                 :input    => 'input',
                 :username => 'user',
                 :password => 'pass',
                 :domain   => 'domain',
                 :account  => 'account' }

    @config_stub   = stub 'config'
    @search_mock   = mock 'search'
    @result_mock   = mock 'result'
    @response_stub = stub 'response'

    Trollop.stub :options => @options
    LogglyRubyClient::Config.should_receive(:new).
                             with(:username => 'user',
                                  :password => 'pass',
                                  :domain   => 'domain',
                                  :account  => 'account').
                             and_return @config_stub
    LogglyRubyClient::Search.should_receive(:new).
                             with(:config => @config_stub).
                             and_return @search_mock
    @search_mock.should_receive(:search).
                 with(:input => 'input',
                      :from   => 'from',
                      :until  => 'until',
                      :query  => 'query',
                      :rows   => 'rows').
                 and_return @result_mock
    @result_mock.stub :response => @response_stub
  end

  it "should put the output of the search api in json" do
    @response_stub.stub :code => '200'
    @response_stub.stub :body => 'thedata'
    s = LogglyRubyClient::CLI::Search.new
    s.should_receive(:puts).with('thedata')
    s.search
  end

  it "should exit with 1 if search api does not return 200 code" do
    @response_stub.stub :code => '404'
    @response_stub.stub :body => 'theerror'
    s = LogglyRubyClient::CLI::Search.new
    s.should_receive(:puts).with('Error: theerror')
    lambda { s.search }.should raise_error SystemExit
  end
end
