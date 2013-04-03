require_relative '../spec_helper'

describe Timesheet do


  describe '#new' do
    let( :timesheet       ) { Timesheet.new activity, requested_month }
    let( :activity        ) { Activity.new                            }
    let( :requested_month ) { DateTime.new                            }
    it "creates a new timesheet given an activity and a month" do
      timesheet = Timesheet.new activity, requested_month
    end
  end

  describe '#facts' do
    let( :timesheet       ) { Timesheet.new activity, requested_month                       }
    let( :activity        ) { Activity.new facts: [ before_fact, fact1, fact2, after_fact ] }
    let( :before_fact     ) { Fact.new start_time: requested_month.prev_month               }
    let( :fact1           ) { Fact.new start_time: requested_month                          }
    let( :fact2           ) { Fact.new start_time: requested_month.next_day                 }
    let( :after_fact      ) { Fact.new start_time: requested_month.next_month               }
    let( :requested_month ) { DateTime.new 2013, 01                                         }
    it "returns only facts included in the requested month" do
      timesheet.facts.should =~ [ fact1, fact2 ]
    end
  end

end