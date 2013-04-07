class FactExhibit
  def initialize fact
    @fact = fact
  end
  def to_html
    html = ''
    html << "<span data-purpose='date_day'>
              #{@fact.start_time.strftime("%a %d")}
             </span>"
    html << "<span data-purpose='minutes_count'>
              #{@fact.duration}
             </span>"
    html << "<span data-purpose='start_time'>
              #{@fact.start_time.hour}:#{@fact.start_time.minute}
             </span>"
    html << '-'
    html << "<span data-purpose='end_time'>
              #{@fact.end_time.hour}:#{@fact.end_time.minute}
             </span>"
    html << "<span data-purpose='description'>
              #{@fact.description}
             </span>"
    "<div data-purpose='fact'>#{html}</div>"
  end
end