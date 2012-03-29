require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Resumly::ProfileOffers do
  let(:profile) {
    Resumly::Profile.new(:subdomain => 'jobs', :name => 'Jobs')
  }
  subject { Resumly::ProfileOffers.new(profile) }
  describe ".new" do
    context "creates new instance" do
      its(:instance_variables) { should == [:@profile] }
    end
  end

  describe "#find" do
    context "gets offer" do
      before {
        Resumly::Offer.should_receive(:find).
            with(profile.subdomain, 1234).
            and_return(Resumly::Offer.new(
              :_id => 1234,
              :title => 'Erlang Developer'))
      }
      it {
        candidate = subject.find(1234)
        candidate._id.should == 1234
        candidate.title.should == 'Erlang Developer'
      }
    end
  end

  describe "#all" do
    context "gets offers" do
      before {
        offers = [
            Resumly::Offer.new(:_id => 1, :title => 'Test1'),
            Resumly::Offer.new(:_id => 2, :title => 'Test2')
        ]
        Resumly::Offer.should_receive(:all).
            with(profile.subdomain, { :page => 1 }).
            and_return(offers)
      }
      it {
        offers = subject.all(:page => 1)
        offers[0]._id.should == 1
        offers[0].title.should == 'Test1'
        offers[1]._id.should == 2
        offers[1].title.should == 'Test2'
      }
    end
  end
end