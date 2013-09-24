require 'base_exhibit'

class FactExhibit < BaseExhibit

  def initialize *args
    super
    @default_format = 'table_row'
  end

  def to_html
   @context.haml template, locals:  { day:         @model.start_time.strftime( '%a %d' ),
                                      duration:    @model.duration,
                                      start_time:  formatted_start_time,
                                      end_time:    formatted_end_time,
                                      description: break_lines( @model.description ),
                                    }
  end

  private

    def break_lines text
      text.to_s.gsub("\n",'<br />')
    end

    def formatted_start_time
      "#{ '%02d' %  @model.start_time.hour }:#{ '%02d' % @model.start_time.minute }"
    end

    def formatted_end_time
      "#{ '%02d' %  @model.end_time.hour   }:#{ '%02d' % @model.end_time.minute   }"
    end

end