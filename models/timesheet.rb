class Timesheet
  def initialize activity, month
    @activity = activity
    @month    = month
  end

  def facts
    @activity.facts
  end

end