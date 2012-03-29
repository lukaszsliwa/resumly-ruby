require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Resumly::Offer do
  describe ".new" do
    context "creates new instance" do
      subject {
        Resumly::Offer.new(
            :_id => 'random-token',
            :title => 'Ruby on Rails Developer',
            :description => 'Looking for hot ruby on rails developer',
            :slug => 'ruby-on-rails-developer',
            :location => 'Cracow',
            :visible => true,
            :locale => 'en',
            :department => 'Software Engineering',
            :url => 'http://corp.resumly.com/abc123-ruby-on-rails-developer',
            :created_at => Time.now,
            :updated_at => Time.now,
            :requirements => ['A', 'B', 'C'],
            :responsibilities => ['D', 'E'],
            :company_offers => ['F', 'G', 'H'],
            :bonus_points => [],
            :additional_information => 'xyz')
      }
      its(:_id) { should == 'random-token' }
      its(:title) { should == 'Ruby on Rails Developer' }
      its(:description) { should == 'Looking for hot ruby on rails developer' }
      its(:slug) { should == 'ruby-on-rails-developer' }
      its(:location) { should == 'Cracow' }
      its(:visible) { should be_true }
      its(:locale) { should == 'en' }
      its(:department) { should == 'Software Engineering' }
      its(:url) { should == 'http://corp.resumly.com/abc123-ruby-on-rails-developer' }
      its(:requirements) { should == ['A', 'B', 'C'] }
      its(:responsibilities) { should == ['D', 'E'] }
      its(:company_offers) { should == ['F', 'G', 'H'] }
      its(:bonus_points) { should == [] }
      its(:additional_information) { should == 'xyz' }
      its(:created_at) { should be_kind_of(Time) }
      its(:updated_at) { should be_kind_of(Time) }
    end
  end

  describe ".find" do
    context "gets offer" do
      before {
        Resumly::Offer.should_receive(:get).
            with("/profiles/profile123/offers/1234").
            and_return({
              :_id => 1234,
              :slug => 'ruby-developer'
            })
      }
      it {
        offer = Resumly::Offer.find('profile123', 1234)
        offer._id.should == 1234
        offer.profile_id.should == 'profile123'
        offer.slug.should == 'ruby-developer'
      }
    end
  end

  describe ".all" do
    context "gets offers" do
      before {
        Resumly::Offer.should_receive(:get).
            with("/profiles/resumly-jobs/offers", :page => 1).
            and_return([
              { :_id => 'test1', :title => 'Test 1' },
              { :_id => 'test2', :title => 'Test 2' }])
      }
      it {
        offers = Resumly::Offer.all('resumly-jobs', :page => 1)
        offers[0]._id.should == 'test1'
        offers[0].profile_id.should == 'resumly-jobs'
        offers[0].title.should == 'Test 1'
        offers[1]._id.should == 'test2'
        offers[1].profile_id.should == 'resumly-jobs'
        offers[1].title.should == 'Test 2'
      }
    end
  end
end