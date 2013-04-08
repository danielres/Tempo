require 'bundler'
Bundler.require
Dir['./models/*.rb'].each{ |f| require f }
Dir['./exhibits/*.rb'].each{ |f| require f }

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

helpers do
  def the name
    { data: { purpose: name } }
  end
  def exhibit object, options={}
    case object
      when Timesheet then TimesheetExhibit.new( object, self, options[:format] )
      when Fact      then      FactExhibit.new( object, self, options[:format] )
    end.to_html
  end
end

get '/' do
  haml :home, locals: { activities: activities }, layout: true
end

get '/activity/:id' do
  timesheets = activity.months.map{ |month| exhibit( Timesheet.new( activity, month ), format: 'table') }
  haml :activity, locals: { activity: activity, timesheets: timesheets }
end

private

  def activity  ; Activity.get params[:id] end
  def activities; Activity.all             end

  def main_page_path        ; '/'                        end
  def activity_path activity; "/activity/#{activity.id}" end

