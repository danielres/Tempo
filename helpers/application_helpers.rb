require 'timesheet'

module ApplicationHelpers

  def timesheets_from_activity activity
    activity.months.map{ |month| Timesheet.new activity, month }
  end
  def the name
    { data: { purpose: name } }
  end
  def exhibit object, options={}
    case object
      when Timesheet then TimesheetExhibit.new( object, self, options[:format] )
      when Fact      then      FactExhibit.new( object, self, options[:format] )
    end.to_html
  end
  def stylesheet_link name
    haml "%link{ rel: 'stylesheet', type: 'text/css', href: '/stylesheets/#{name}.css' }"
  end

end