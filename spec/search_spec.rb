require 'spec_helper'

describe LogglyRubyClient::Search do
  it "should call the search api" do
    api_mock = mock 'api'
    LogglyRubyClient::API.should_receive(:new).
                          with(:config => 'cfg').
                          and_return api_mock
    LogglyRubyClient::Config.should_receive(:new).
                             with(:domain      => 'dom',
                                  :username    => 'user',
                                  :password    => 'pass',
                                  :account     => 'acct',
                                  :config_file => 'dafile').
                             and_return 'cfg'
    api_mock.should_receive(:search).
             with(:query => 'test').
             and_return 'thedata'

    s = LogglyRubyClient::Search.new :domain      => 'dom',
                                     :username    => 'user',
                                     :password    => 'pass',
                                     :account     => 'acct',
                                     :config_file => 'dafile'

    s.search(:query => 'test').should == 'thedata'
  end
end
