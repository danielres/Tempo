require 'bundler'
Bundler.require

$: << 'models' << 'exhibits' << 'engines'

require 'activity'
require 'category'
require 'fact'
require 'tag'
require 'timesheet'
require 'fact_exhibit'
require 'timesheet_exhibit'
require 'sass_engine'


DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

use SassEngine

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
  def stylesheet_link name
    haml "%link{ rel: 'stylesheet', type: 'text/css', href: '/stylesheets/#{name}.css' }"
  end
end


get '/' do
  activities = Activity.all
  haml :home, locals: { activities: activities }, layout: :page_layout
end

get '/activity/:id' do
  activity   = Activity.get params[:id]
  timesheets = timesheets_for_activity activity
  timesheets = timesheets.map{ |timesheet| exhibit timesheet, format: 'table' }
  haml :activity, locals: { activity:   activity,
                            timesheets: timesheets,
                            page_title: "Timesheets for #{ activity.name.capitalize }",
                          },
                          layout: :page_layout
end

private

  def timesheets_for_activity activity
    months      = activity.months
    timesheets  = months.map{ |month| Timesheet.new activity, month }
  end


  def main_page_path        ; '/'                        end
  def activity_path activity; "/activity/#{activity.id}" end

