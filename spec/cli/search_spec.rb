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
  end

  it "should put the output of the search api in json" do
    result = { :code => "200",
               :body => { 'test' => '123' } }
    @search_mock.should_receive(:search).
                 with(:input => 'input',
                      :from   => 'from',
                      :until  => 'until',
                      :query  => 'query',
                      :rows   => 'rows').
                 and_return result
    s = LogglyRubyClient::CLI::Search.new
    s.should_receive(:jj).with result[:body]
    s.search
  end

  it "should exit with 1 if search api does not return 200 code" do
    result = { :code  => "404",
               :error => 'theerror',
               :body  => '' }
    @search_mock.should_receive(:search).
                 with(:input => 'input',
                      :from   => 'from',
                      :until  => 'until',
                      :query  => 'query',
                      :rows   => 'rows').
                 and_return result
    s = LogglyRubyClient::CLI::Search.new
    s.should_receive(:puts).with('Error: theerror')
    lambda { s.search }.should raise_error SystemExit
  end
end
