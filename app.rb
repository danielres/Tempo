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
   text << exhibit_timesheet( Timesheet.new( activity, month ) )
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

  def exhibit_timesheet timesheet
    html = ''
    timesheet.facts.each {|fact| html << exhibit_fact(fact) }
    "<div data-purpose='timesheet'>
     <h2>Timesheet</h2>
     #{html}
       <div class='time_spent'>
       <span data-purpose='total_hours_count'>#{timesheet.total_hours_count} hours</span>
       <span data-purpose='total_hours_count'>(#{timesheet.total_minutes_count} minutes)</span>
       </div>
     </div>"
  end

  def exhibit_fact fact
    html = ''

    html << "<span data-purpose='minutes_count'>
              #{fact.duration}
             </span>"
    html << "<span data-purpose='description'>
              #{fact.description}
             </span>"
    html << "<span data-purpose='start_time'>
              #{fact.start_time.hour}:#{fact.start_time.minute}
             </span>"
    html << '-'
    html << "<span data-purpose='end_time'>
              #{fact.end_time.hour}:#{fact.end_time.minute}
             </span>"
    "<div data-purpose='fact'>#{html}</div>"
  end