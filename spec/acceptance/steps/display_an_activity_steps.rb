steps_for :display_an_activity do

  step "an activity :name that was practiced during :num_months months" do |name, num_months|
    @activity = Activity.new id: 1, name: name
    month1 = DateTime.new 2012, 1
    month2 = month1.next_month
    month3 = month2.next_month
    2.times{ @activity.facts << Fact.new( start_time: month1 ) }
    3.times{ @activity.facts << Fact.new( start_time: month2 ) }
    4.times{ @activity.facts << Fact.new( start_time: month3 ) }
    Activity.stub(:get).and_return @activity
  end

  step "I visit the activity page" do
    visit activity_path @activity
  end

  step "I should see :count timesheets" do |count|
    page.should have_the 'timesheet', count: count
  end

end