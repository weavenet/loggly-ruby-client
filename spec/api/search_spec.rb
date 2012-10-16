require 'spec_helper'

describe LogglyRubyClient::API::Search do
  before do
    @config_stub = stub 'config'
    @connect_mock = mock 'connect'
    LogglyRubyClient::API::Connect.should_receive(:new).
                                   with(:config => @config_stub).
                                   and_return @connect_mock
    @search = LogglyRubyClient::API::Search.new :config => @config_stub
  end

  it "should search across multiple queries & inputs" do
    data = '/api/search?q=query1%20AND%20query2%20AND%20inputname:input1%20OR%20inputname:input2&from=from&rows=5&until=till'
    @connect_mock.should_receive(:run).
                  with(data).
                  and_return 'result'
    @search.search(:from  => 'from',
                   :until => 'till',
                   :query => ['query1', 'query2'],
                   :input => ['input1', 'input2'],
                   :rows  => 5).should == 'result'
  end

  it "should search querieses without inputs" do
    data = '/api/search?q=query1%20AND%20query2&from=from&rows=5&until=till'
    @connect_mock.should_receive(:run).
                  with(data).
                  and_return 'result'
    @search.search(:from  => 'from',
                   :until => 'till',
                   :query => ['query1', 'query2'],
                   :input => [],
                   :rows  => 5).should == 'result'
  end

  it "should search inputs without queries" do
    data = '/api/search?q=inputname:input1%20OR%20inputname:input2&from=from&rows=5&until=till'
    @connect_mock.should_receive(:run).
                  with(data).
                  and_return 'result'
    @search.search(:from  => 'from',
                   :until => 'till',
                   :query => [],
                   :input => ['input1', 'input2'],
                   :rows  => 5).should == 'result'
  end

  it "should conver spaces in queries to %20" do
    data = '/api/search?q=1%20AND%202%203%20AND%204%205%20%206&from=from&rows=5&until=till'
    @connect_mock.should_receive(:run).
                  with(data).
                  and_return 'result'
    @search.search(:from  => 'from',
                   :until => 'till',
                   :query => ['1', '2 3', '4 5  6'],
                   :input => [],
                   :rows  => 5).should == 'result'
  end

end
