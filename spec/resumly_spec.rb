require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Resumly" do
  context "gets default version and host" do
    subject { Resumly }
    its(:host) { should == 'api.resumly.com' }
    its(:version) { should == 'v1' }
  end

  context "sets token, version and host" do
    subject { Resumly }
    before {
      Resumly.configure do |resumly|
        resumly.token = 'token123'
        resumly.host  = 'api1.resumly.com'
        resumly.version = 'v1.1'
      end
    }
    its(:token) { should == 'token123' }
    its(:host) { should == 'api1.resumly.com' }
    its(:version) { should == 'v1.1' }
  end
end
