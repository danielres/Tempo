require 'bundler'
Bundler.require

Dir['./models/*.rb'].each{ |f| require f }

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")
DataMapper.finalize

get '/' do
  "<h1>Tempo</h1>" +
  "<h2>Dashboard</h2>" +
  Activity.all.map(&:name).join(',')
end
