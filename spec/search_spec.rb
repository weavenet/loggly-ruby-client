require 'spec_helper'

describe LogglyRubyClient::Search do
  it "should call the search api" do
    api_mock = mock 'api'
    LogglyRubyClient::API.should_receive(:new).
                          with(:config => 'cfg').
                          and_return api_mock
    api_mock.should_receive(:search).
             with(:query => 'test').
             and_return 'thedata'

    s = LogglyRubyClient::Search.new :config => 'cfg'
    s.search(:query => 'test').should == 'thedata'
  end
end
