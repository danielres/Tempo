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
    let( :activity1  ){ double.as_null_object }
    let( :activity2  ){ double.as_null_object }
    let( :activities ){ [ activity1, activity2 ] }
    let( :category_with_activities ){ Category.new.tap{ |c| c.activities = activities } }
    it "has many activities" do
      expect( category_with_activities.activities ).to match_array activities
    end
  end

end