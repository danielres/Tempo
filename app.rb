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
  timesheets = activity.months.map{ |month| exhibit Timesheet.new( activity, month ) }
  haml :activity, locals: { activity: activity, timesheets: timesheets }
end

private

  def activity  ; Activity.get params[:id] end
  def activities; Activity.all             end

  def main_page_path        ; '/'                        end
  def activity_path activity; "/activity/#{activity.id}" end

  def exhibit object
    case object
      when Timesheet then TimesheetExhibit.new(object)
      when Fact      then      FactExhibit.new(object)
    end.to_html
  end


