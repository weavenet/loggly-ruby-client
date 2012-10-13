require 'spec_helper'

describe LogglyRubyClient::API::Connect do

  before do
    @config_stub   = stub 'config', :username => 'user',
                                    :password => 'pass',
                                    :domain   => 'dom'
    @connect = LogglyRubyClient::API::Connect.new :config => @config_stub
  end

  it "should return the results for a succesfuly query" do
    response_stub = stub 'response', "body"  => '{ "test":"123" }',
                                     "code"  => "200",
                                     "error" => 'theerror'
    result_stub   = stub 'result', :response => response_stub 
    HTTParty.should_receive(:get).
             with("https://dom.loggly.comsearchit", { :basic_auth => { :username => "user", :password => "pass" } }).
             and_return result_stub
    expected_result = { "code" => "200", 
                        "error"=> "",
                        "body" => { "test" => "123" } }
    @connect.run('searchit').should == expected_result
  end

  it "should return the results for an unsuccesfuly query" do
    response_stub = stub 'response', "body"  => "Da Message",
                                     "code"  => "404",
                                     "error" => 'theerror'
    result_stub   = stub 'result', :response => response_stub 
    HTTParty.should_receive(:get).
             with("https://dom.loggly.comsearchit", { :basic_auth => { :username => "user", :password => "pass" } }).
             and_return result_stub
    expected_result = { "code"  => "404", 
                        "error" => "Da Message",
                        "body"  => "" }
    @connect.run('searchit').should == expected_result
  end
end

