require 'bundler'
Bundler.require

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")

class Tag
  include DataMapper::Resource
  property :id,   Serial
  property :name, String
end

