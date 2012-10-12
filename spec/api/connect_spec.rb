require 'spec_helper'

describe LogglyRubyClient::API::Connect do
  it "should run the give command" do
    config_stub = stub 'config', :username => 'user',
                                 :password => 'pass',
                                 :domain   => 'dom'
    connect = LogglyRubyClient::API::Connect.new :config => config_stub
    HTTParty.should_receive(:get).
             with("https://dom.loggly.comsearchit", { :basic_auth => { :username => "user", :password => "pass" } }).
             and_return('theresult')
    connect.run('searchit').should == 'theresult'
  end
end

