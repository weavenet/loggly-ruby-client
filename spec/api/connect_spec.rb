require 'spec_helper'

describe LogglyRubyClient::API::Connect do
  it "should run the given command" do
    code_stub     = stub 'result'
    response_stub = stub 'response', :body => '{ "test":"123" }',
                                     :code => 200
    result_stub   = stub 'result', :response => response_stub 
    config_stub   = stub 'config', :username => 'user',
                                   :password => 'pass',
                                   :domain   => 'dom'
    connect = LogglyRubyClient::API::Connect.new :config => config_stub
    HTTParty.should_receive(:get).
             with("https://dom.loggly.comsearchit", { :basic_auth => { :username => "user", :password => "pass" } }).
             and_return result_stub
    expected_result = { :code => 200, :body => { "test" => "123" } }
    connect.run('searchit').should == expected_result
  end
end

