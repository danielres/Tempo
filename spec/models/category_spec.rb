require_relative '../spec_helper'

describe Category do

  let(:category) { Category.new }

  it "should have proper attributes" do
    attributes  = [ :id, :name, :color_code, :category_order, :search_name ]
    attributes.each{ |attribute| category.should respond_to attribute }
  end

  it "should have many activities" do
    activity1                = Activity.new
    activity2                = Activity.new
    activities               = [ activity1, activity2 ]
    category_with_activities = category.tap{ |c| c.activities = activities }
    category_with_activities.activities.should == [ activity1, activity2 ]
  end

end