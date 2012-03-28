require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Resumly::Profile do
  describe ".new" do
    context "creates new instance" do
      subject {
        Resumly::Profile.new(
            :subdomain => 'jobs',
            :name => "Resumly Jobs",
            :created_at => Time.now)
      }
      its(:subdomain) { should == 'jobs' }
      its(:name) { should == 'Resumly Jobs' }
      its(:created_at) { should be_kind_of(Time) }
    end
  end

  describe ".find" do
    context "gets profile" do
      before {
        Resumly::Profile.should_receive(:get).
            with("/profiles/profile123").
            and_return({
              :name => 'Resumly Jobs',
              :subdomain => 'jobs',
              :created_at => Time.now
            })
      }
      it {
        profile = Resumly::Profile.find('profile123')
        profile.name.should == 'Resumly Jobs'
        profile.subdomain.should == 'jobs'
        profile.created_at.should be_kind_of(Time)
      }
    end
  end

  describe ".all" do
    context "gets profiles" do
      before {
        Resumly::Profile.should_receive(:get).
            with("/profiles", :page => 1).
            and_return([
              { :name => 'Test 1', :subdomain => 'test1' },
              { :name => 'Test 2', :subdomain => 'test2' }])
      }
      it {
        profiles = Resumly::Profile.all(:page => 1)
        profiles[0].name.should == 'Test 1'
        profiles[0].subdomain.should == 'test1'
        profiles[1].name.should == 'Test 2'
        profiles[1].subdomain.should == 'test2'
      }
    end
  end
end
