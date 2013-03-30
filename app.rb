require 'bundler'
Bundler.require
Dir["./models/*.rb"].each { |file| require file }
DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")