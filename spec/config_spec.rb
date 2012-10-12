require 'spec_helper'

describe LogglyRubyClient::Config do

  context "with config file" do
    before do
      data = { 
               'lc' => 
                 {
                   'username' => 'test_username',
                   'password' => 'test_password',
                   'domain'   => 'test_domain'
                 }
             }

      File.stub :exists? => true
      File.should_receive(:open).
           with("#{ENV['HOME']}/.loggly-ruby-client.yml").
           and_return data.to_yaml
    end

    it "should load the config from a file" do
      config = LogglyRubyClient::Config.new :account => 'lc'
      config.domain.should == 'test_domain'
      config.username.should == 'test_username'
      config.password.should == 'test_password'
    end

    it "should override with config passed in" do
      config = LogglyRubyClient::Config.new :account  => 'lc',
                                            :username => 'newuser',
                                            :password => 'newpass',
                                            :domain   => 'newdom'
      config.domain.should == 'newdom'
      config.username.should == 'newuser'
      config.password.should == 'newpass'
    end
  end

  context "without config file" do
    it "should not blow up if config does not exist" do
      File.stub :exists? => false
      LogglyRubyClient::Config.new
    end
  end

end
