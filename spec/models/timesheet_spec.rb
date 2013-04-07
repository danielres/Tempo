require_relative '../spec_helper'
require_relative '../../models/timesheet'

describe Timesheet do

  describe '#new' do
    before { stub_const 'Activity', DummyModel }
    let( :timesheet ){ Timesheet.new activity, month }
    let( :activity  ){ Activity.new }
    let( :month     ){ DateTime.new 2013,01 }
    it "creates a new timesheet given an activity and a month" do
      Timesheet.new activity, month
    end
  end

  describe 'with facts' do
    before { stub_const 'Activity', DummyModel }
    before { stub_const 'Fact',     DummyModel }
    let( :activity_with_facts  ){ a=Activity.new.tap{ |a| a.stub facts: facts } }
    let( :month          ){ DateTime.new 2013, 01 }
    let( :timesheet      ){ Timesheet.new activity_with_facts, month }
    let( :fact1          ){ Fact.new.tap{ |f| f.stub start_time: month} }
    let( :fact2          ){ Fact.new.tap{ |f| f.stub start_time: month.next_day } }
    let( :earlyer_fact   ){ Fact.new.tap{ |f| f.stub start_time: month.prev_month } }
    let( :later_fact     ){ Fact.new.tap{ |f| f.stub start_time: month.next_month } }
    let( :facts          ){ [ earlyer_fact, fact1, fact2, later_fact ] }

    describe '#facts' do
      it "returns only the facts that happened in a precise month" do
        timesheet.facts.should =~ [ fact1, fact2 ]
      end
    end

    describe '#total_minutes_count' do
      before { fact1.stub duration: 10 }
      before { fact2.stub duration: 20 }
      it "returns the total minutes count of the facts" do
        timesheet.total_minutes_count.should == 30
      end
    end

  end


end