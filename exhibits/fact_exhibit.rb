class FactExhibit

  def initialize fact, context, format
    @fact    = fact
    @context = context
    @format  = format
  end

  def to_html
   @context.haml template, locals:  { day:         @fact.start_time.strftime( '%a %d' ),
                                      duration:    @fact.duration,
                                      start_time:  "#{@fact.start_time.hour}:#{@fact.start_time.minute}",
                                      end_time:    "#{@fact.end_time.hour}:#{@fact.end_time.minute}",
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

end