require 'bundler'
Bundler.require

Dir['./models/*.rb'].each{ |f| require f }

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")

get '/' do
  "<h1>Tempo</h1>" +e
  "<h2>Dashboard</h2>"
end
