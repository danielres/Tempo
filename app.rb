require 'bundler'
Bundler.require

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/db/hamster.db")

class Tag
  include DataMapper::Resource
  property :id,             Serial
  property :name,           String
end

class Activity
  include DataMapper::Resource
  property :id,             Serial
  property :name,           String
  property :work,           Integer
  property :activity_order, Integer
  property :deleted,        Integer
  property :category_id,    Integer
  property :search_name,    String
end

class Category
  include DataMapper::Resource
  property :id,             Serial
  property :name,           String
  property :color_code,     String
  property :category_order, Integer
  property :search_name,    String
end

class Fact
  include DataMapper::Resource
  property :id,             Serial
  property :start_time,     DateTime
  property :end_time,       DateTime
  property :description,    String
end