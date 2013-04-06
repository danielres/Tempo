require_relative '../spec_helper'
require_relative '../../models/activity'


describe Activity do

  let( :activity ){ Activity.new }

  describe '#new' do
    it "has proper attributes" do
      attributes  = %w( id name work activity_order deleted category_id search_name )
      attributes.each{ |attribute| activity.should respond_to attribute }
    end
  end

  describe '#category' do
    before { stub_const 'Category', DummyModel }
    let( :category ){ Category.new }
    let( :activity ){ Activity.new.tap{ |a| a.category = category } }
    it "belongs to a category" do
      activity.category.should == category
    end
  end

  describe '#facts' do
    before { stub_const 'Fact', DummyModel }
    let( :fact1               ){ Fact.new }
    let( :fact2               ){ Fact.new }
    let( :facts               ){ [ fact1, fact2 ] }
    let( :activity_with_facts ){ Activity.new.tap{ |a| a.facts = facts } }
    it "has many facts" do
      facts.count.times do |i|
        activity_with_facts.facts.sort[i].should equal facts.sort[i]
      end
    end
  end

  describe '#months' do
    before { stub_const 'Fact', DummyModel }
    it "returns a list of months when the activity occurs" do
      month1  = DateTime.new( 2012, 1 )
      month2  = DateTime.new( 2013, 1 )
      month3  = DateTime.new( 2013, 2 )
      ( fact1 = Fact.new ).stub start_time: month1
      ( fact2 = Fact.new ).stub start_time: month2
      ( fact3 = Fact.new ).stub start_time: month2
      ( fact4 = Fact.new ).stub start_time: month3
      facts   = [ fact1, fact2, fact3, fact4 ]
      activity_with_facts = activity.tap{ |c| c.facts = facts }
      activity_with_facts.months.should =~ [ month1, month2, month3 ]
    end
  end

end