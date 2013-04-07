require 'bundler'
Bundler.require

Dir['./models/*.rb'].each{ |f| require f }

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

get '/' do
  "<h1>Tempo</h1>"                 +
  '<div data-purpose="activities-list">' +
  "<h2>Activities</h2>"             +
  make_links(activities)           +
  '</div>'
end

get '/activity/:id' do
  text = ""
  text << "<h1>Timesheets for #{activity.name}</h1>"
  activity_months(activity).each do |month|
   text << exhibit( Timesheet.new( activity, month ) )
  end
  text
end

private

  def activity
    Activity.get params[:id]
  end

  def activities
    Activity.all
  end

  def make_links objects
    objects.map do |o|
      link_text = o.name
      link_href = "/#{o.class.to_s.downcase}/#{o.id}"
      "<a href='#{link_href}'>#{link_text}</a>"
    end.join(' ')
  end

  def activity_months activity
    activity.months
  end

  def exhibit object
    case object
      when Timesheet then TimesheetExhibit.new(object)
      when Fact      then      FactExhibit.new(object)
    end.to_html
  end

  class TimesheetExhibit
    def initialize timesheet
      @timesheet = timesheet
    end
    def to_html
      html = ''
      @timesheet.facts.each {|fact| html << exhibit(fact) }
      "<div data-purpose='timesheet'>
       <h2>Timesheet for #{@timesheet.year}-#{@timesheet.month}</h2>
       #{html}
         <div class='time_spent'>
         <span data-purpose='total_hours_count'>#{@timesheet.total_hours_count} hours</span>
         <span data-purpose='total_hours_count'>(#{@timesheet.total_minutes_count} minutes)</span>
         </div>
       </div>"
    end
  end

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