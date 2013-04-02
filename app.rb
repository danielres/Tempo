require 'bundler'
Bundler.require

Dir['./models/*.rb'].each{ |f| require f }

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

get '/' do
  "<h1>Tempo</h1>" +
  "<h2>Dashboard</h2>" +
  make_links(activities)
end

get '/activity/:id' do
  "Timesheet for #{activity.name}"
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
