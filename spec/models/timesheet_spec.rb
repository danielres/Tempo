require_relative '../spec_helper'

describe Timesheet do

  let(:activity){ Activity.new }
  let(:month   ){ DateTime.new 2013, 01 }

  it "creates a new timesheet given an activity and a month" do
    timesheet = Timesheet.new( activity, month )
  end





end