class TimesheetExhibit

  def initialize timesheet, context
    @timesheet = timesheet
    @context   = context
  end

  def to_html
    @context.haml template, locals: { timesheet:           @timesheet,
                                      facts:               facts_html,
                                      total_hours_count:   @timesheet.total_hours_count,
                                      total_minutes_count: @timesheet.total_minutes_count
                                    }
  end

  private

    def template
      File.read "#{@context.settings.root}/views/exhibits/timesheet.haml"
    end

    def facts_html
      @timesheet.facts.map{ |fact| exhibit fact }.join
    end

end