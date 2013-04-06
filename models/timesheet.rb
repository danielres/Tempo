class Timesheet
  def initialize activity, month
    @activity = activity
    @month    = month
  end

  def facts
    @activity.facts
             .select{ |f| f.start_time.year  == @month.year  }
             .select{ |f| f.start_time.month == @month.month }
  end

end