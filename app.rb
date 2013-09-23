require 'bundler'
Bundler.require

$: << 'models' << 'exhibits' << 'engines'

require 'activity'
require 'category'
require 'fact'
require 'tag'
require 'fact_exhibit'
require 'timesheet_exhibit'
require 'sass_engine'
require_relative './helpers'


DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

use SassEngine

helpers Helpers

get '/' do
  activities = Activity.all
  haml :home, locals: { activities: activities }, layout: :page_layout
end

get '/activity/:id' do
  activity   = Activity.get params[:id]
  timesheets = timesheets_from_activity activity
  timesheets = timesheets.map{ |timesheet| exhibit timesheet, format: 'table' }
  haml :activity, locals: { activity:   activity,
                            timesheets: timesheets,
                            page_title: "Timesheets for #{ activity.name.capitalize }",
                          },
                          layout: :page_layout
end

private


  def main_page_path        ; '/'                        end
  def activity_path activity; "/activity/#{activity.id}" end

