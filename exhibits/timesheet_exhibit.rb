class TimesheetExhibit
  def initialize timesheet
    @timesheet = timesheet
  end
  def to_html
    html = ''
    @timesheet.facts.each {|fact| html << exhibit(fact) }
    "
      <div data-purpose='timesheet'>
        <h2>Timesheet for #{@timesheet.year}-#{@timesheet.month}</h2>
        #{html}
        <div class='time_spent'>
          <span data-purpose='total_hours_count'>#{@timesheet.total_hours_count} hours</span>
          <span data-purpose='total_hours_count'>(#{@timesheet.total_minutes_count} minutes)</span>
        </div>
      </div>
    "
  end
end