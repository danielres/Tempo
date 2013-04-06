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

end