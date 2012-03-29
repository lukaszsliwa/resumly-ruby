require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Resumly::ProfileCandidates do
  let(:profile) {
    Resumly::Profile.new(:subdomain => 'jobs', :name => 'Jobs')
  }
  subject { Resumly::ProfileCandidates.new(profile) }
  describe ".new" do
    context "creates new instance" do
      its(:instance_variables) { should == [:@profile] }
    end
  end

  describe "#find" do
    context "gets candidate" do
      before {
        Resumly::Candidate.should_receive(:find).
            with(profile.subdomain, 1234).
            and_return(Resumly::Candidate.new(
              :_id => 1234,
              :email => 'test@test.pl',
              :screen_name => 'Test'))
      }
      it {
        candidate = subject.find(1234)
        candidate._id.should == 1234
        candidate.email.should == 'test@test.pl'
        candidate.screen_name.should == 'Test'
      }
    end
  end

  describe "#all" do
    context "gets candidates" do
      before {
        candidates = [
            Resumly::Candidate.new(:_id => 1, :email => 'test1@resumly.com', :screen_name => 'Test1'),
            Resumly::Candidate.new(:_id => 2, :email => 'test2@resumly.com', :screen_name => 'Test2')
        ]
        Resumly::Candidate.should_receive(:all).
            with(profile.subdomain, { :page => 1 }).
            and_return(candidates)
      }
      it {
        candidates = subject.all(:page => 1)
        candidates[0]._id.should == 1
        candidates[0].email.should == 'test1@resumly.com'
        candidates[0].screen_name.should == 'Test1'
        candidates[1]._id.should == 2
        candidates[1].email.should == 'test2@resumly.com'
        candidates[1].screen_name.should == 'Test2'
      }
    end
  end
end
