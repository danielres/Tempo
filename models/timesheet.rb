class Timesheet
  def initialize activity, requested_month
    @activity         = activity
    @requested_month  = requested_month
  end

  def facts
    @activity.facts
             .select{ |f| f.start_time.year  == @requested_month.year  }
             .select{ |f| f.start_time.month == @requested_month.month }
  end

end