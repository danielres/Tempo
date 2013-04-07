require_relative '../spec_helper'
require_relative '../../models/fact'


describe Fact do

  let( :fact ){ Fact.new }

  describe '#new' do
    it "has proper attributes" do
      attributes  = %w( id start_time end_time description )
      attributes.each{ |attribute| fact.should respond_to attribute }
    end
  end

  describe '#activity' do
    before { stub_const 'Activity', DummyModel }
    let( :activity ){ Activity.new }
    let( :fact ){ Fact.new.tap{ |f| f.activity = activity } }
    it "belongs to an activity" do
      fact.activity.should == activity
    end
  end

  describe '#duration' do
    start_time = Time.new 2013,1,1,1,0
    duration   = 10*60 # 10 minutes
    end_time   = start_time + duration
    before { fact.stub( start_time: start_time, end_time: end_time  ) }
    it "returns its duration in minutes" do
      fact.duration.should == 10
    end
  end

end