require_relative '../spec_helper'

describe Timesheet do

  let( :activity   ) { Activity.new                  }
  let( :month      ) { DateTime.new 2013, 01         }
  let( :fact1      ) { Fact.new                      }
  let( :fact2      ) { Fact.new                      }
  let( :facts      ) { [ fact1, fact2 ]              }
  let( :timesheet  ) { Timesheet.new activity, month }

  it "creates a new timesheet given an activity and a month" do
    timesheet = Timesheet.new activity, month
  end

  it "gets its facts from the activity" do
    activity.stub facts: facts
    timesheet.facts.should == facts
  end

end