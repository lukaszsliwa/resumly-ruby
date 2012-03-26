require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Resumly" do
  context "sets token, version and host" do
    subject { Resumly }
    before {
      Resumly.configure do |resumly|
        resumly.token = 'token123'
        resumly.host  = 'api.resumly.com'
        resumly.version = 'v1'
      end
    }
    its(:token) { should == 'token123' }
    its(:host) { should == 'api.resumly.com' }
    its(:version) { should == 'v1' }
  end
end
