require 'spec_helper'
require 'timesheet'

describe Timesheet do

  describe 'new timesheet' do
    context 'for a given activity and month' do
      let( :activity  ){ double 'activity' }
      let( :month     ){ DateTime.new 2013, 01 }
      let( :timesheet     ){ Timesheet.new activity, month }
      it 'has its activity correctly set' do
        expect( timesheet.activity ).to be activity
      end
      it 'has its month correctly set' do
        expect( timesheet.month ).to be 1
      end
    end
  end

  describe 'having facts' do
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

    describe '#total_hours_count' do
      before { timesheet.stub total_minutes_count: 332 }
      it "returns the total_hours_count of the facts, rouded to the first decimal" do
        timesheet.total_hours_count.should == 5.5 # 322 minutes = 5.533 hours
      end
    end

    describe '#month' do
      it 'returns the month of the timesheet period as simple number' do
        timesheet.month.should == 1
      end
    end

    describe '#year' do
      it 'returns the year of the timesheet period as a simple number' do
        timesheet.year.should == 2013
      end
    end
  end


end