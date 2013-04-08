require 'bundler'
Bundler.require

Dir['./models/*.rb'].each{ |f| require f }
Dir['./exhibits/*.rb'].each{ |f| require f }

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

get '/' do
  haml :home, activities: activities
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

  def activity_months activity
    activity.months
  end

  def exhibit object
    case object
      when Timesheet then TimesheetExhibit.new(object)
      when Fact      then      FactExhibit.new(object)
    end.to_html
  end

