class TimesheetExhibit

  def initialize timesheet, context, format
    @timesheet = timesheet
    @context   = context
    @format    = format
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
      File.read "#{@context.settings.root}/views/exhibits/timesheet/#{@format}.haml"
    end

    def facts_html
      @timesheet.facts.map{ |fact| FactExhibit.new( fact, @context, 'table_row' ).to_html }.join


    end

end