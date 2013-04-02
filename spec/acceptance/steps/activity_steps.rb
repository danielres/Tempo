

# module ActivitySteps

  step "an activity :name with some facts" do |name|
    @activity = Activity.new id: 1, name: name
    Activity.stub(:get).and_return @activity
  end

  step "I visit the activity page" do
    visit activity_path @activity
  end

  step "I should see a timesheet for :activity with the facts" do |activity|
    page.should have_content "Timesheet for #{activity}"
  end

# end