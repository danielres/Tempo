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

  it "has many facts" do
    fact1               = Fact.new
    fact2               = Fact.new
    facts               = [ fact1, fact2 ]
    activity_with_facts = activity.tap{ |c| c.facts = facts }
    activity_with_facts.facts.should == [ fact1, fact2 ]
  end

end