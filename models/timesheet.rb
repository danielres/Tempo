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

  def total_minutes_count
    total = 0
    facts.each{ |f| total += f.duration }
    total
  end

end