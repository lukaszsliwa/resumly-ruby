require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Resumly::Candidate do
  describe ".new" do
    context "creates new instance" do
      subject {
        Resumly::Candidate.new(
            :_id => 'randomtoken',
            :email => 'ceo@resumly.com',
            :screen_name => 'Johnny Jobs',
            :position => 'CEO',
            :comments => [],
            :tags => [],
            :created_at => Time.now,
            :updated_at => Time.now)
      }
      its(:_id) { should == 'randomtoken' }
      its(:email) { should == 'ceo@resumly.com' }
      its(:screen_name) { should == 'Johnny Jobs' }
      its(:position) { should == 'CEO' }
      its(:comments) { should == [] }
      its(:tags) { should == [] }
      its(:created_at) { should be_kind_of(Time) }
      its(:updated_at) { should be_kind_of(Time) }
    end
  end

  describe ".find" do
    context "gets candidate" do
      before {
        Resumly::Candidate.should_receive(:get).
            with("/profiles/profile123/candidates/1234").
            and_return({
              :email => 'kowalski@wp.pl',
              :screen_name => 'Jan Kowalski',
              :created_at => Time.now,
              :updated_at => Time.now
            })
      }
      it {
        candidate = Resumly::Candidate.find('profile123', 1234)
        candidate.email.should == 'kowalski@wp.pl'
        candidate.screen_name.should == 'Jan Kowalski'
        candidate.created_at.should be_kind_of(Time)
        candidate.updated_at.should be_kind_of(Time)
      }
    end
  end

  describe ".all" do
    context "gets candidates" do
      before {
        Resumly::Candidate.should_receive(:get).
            with("/profiles/resumly-jobs/candidates", :page => 1).
            and_return([
              { :email => 'test1@test.pl', :screen_name => 'Test1 Test1' },
              { :email => 'test2@test.pl', :screen_name => 'Test2 Test2' }])
      }
      it {
        candidates = Resumly::Candidate.all('resumly-jobs', :page => 1)
        candidates[0].email.should == 'test1@test.pl'
        candidates[0].screen_name.should == 'Test1 Test1'
        candidates[1].email.should == 'test2@test.pl'
        candidates[1].screen_name.should == 'Test2 Test2'
      }
    end
  end
end