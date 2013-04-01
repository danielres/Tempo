require_relative '../spec_helper'

describe Activity do

  let(:activity) { Activity.new }

  it "has proper attributes" do
    attributes  = [ :id, :name, :work, :activity_order, :deleted, :category_id, :search_name ]
    attributes.each{ |attribute| activity.should respond_to attribute }
  end

  it "belongs to a category" do
    category                  = Category.new
    activity.category         = category
    activity.category.should == category
  end

end