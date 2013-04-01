class Activity
  include DataMapper::Resource
  property :id,             Serial
  property :name,           String
  property :work,           Integer
  property :activity_order, Integer
  property :deleted,        Integer
  property :category_id,    Integer
  property :search_name,    String
  belongs_to :category
  has n, :facts
end