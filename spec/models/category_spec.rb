require_relative '../spec_helper'
require_relative '../../models/category'


describe Category do

  let(:category) { Category.new }

  describe '#new' do
    it "has proper attributes" do
      attributes  = %w( id name color_code category_order search_name )
      attributes.each{ |attribute| category.should respond_to attribute }
    end
  end

  describe '#activities' do
    class Activity < DummyModel; end
    let( :activity1  ){ Activity.new }
    let( :activity2  ){ Activity.new }
    let( :activities ){ [ activity1, activity2 ] }
    let( :category_with_activities ){ Category.new.tap{ |c| c.activities = activities } }
    it "has many activities" do
      activities.count.times do |i|
        category_with_activities.activities.sort[i].should equal activities.sort[i]
      end
    end
  end

end