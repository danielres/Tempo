class FactExhibit

  def initialize fact, context, format
    @fact    = fact
    @context = context
    @format  = format
  end

  def to_html
   @context.haml template, locals:  { day:         @fact.start_time.strftime( '%a %d' ),
                                      duration:    @fact.duration,
                                      start_time:  formatted_start_time,
                                      end_time:    formatted_end_time,
                                      description: break_lines( @fact.description ),
                                    }
  end

  private

    def template
      File.read "#{@context.settings.root}/views/exhibits/fact/#{@format}.haml"
    end

    def break_lines text
      text.to_s.gsub("\n",'<br />')
    end

    def formatted_start_time
      "#{ '%02d' %  @fact.start_time.hour }:#{ '%02d' % @fact.start_time.minute }"
    end

    def formatted_end_time
      "#{ '%02d' %  @fact.end_time.hour }:#{ '%02d' % @fact.end_time.minute }"
    end

end