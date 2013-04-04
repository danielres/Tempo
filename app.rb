require 'bundler'
Bundler.require

Dir['./models/*.rb'].each{ |f| require f }

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

get '/' do
  "<h1>Tempo</h1>"                 +
  '<div data-purpose="dashboard">' +
  "<h2>Dashboard</h2>"             +
  make_links(activities)           +
  '</div>'
end

get '/activity/:id' do
  text = ""
  text << "<h1>Timesheets for #{activity.name}</h1>"
  activity_months(activity).each do |month|
   text << "<div class='timesheet'>
              <h2>Timesheet for #{month.year}-#{month.month}</h2>
              #{ Timesheet.new( activity, month ) }
            </div>"
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

  def timesheets_for activity
    activity_months.map do |month|
      Timesheet.new activity, month
    end
  end

  def activity_months activity
    activity.months
  end