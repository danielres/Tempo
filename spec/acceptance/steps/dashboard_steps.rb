

# module DashboardSteps

  step "activities: :names_list" do |names_list|
    names = Array.new names_list.split(',').map(&:strip)
    names.each{ |name| ( @activities ||= [] ) << Activity.new( name: name ) }
    Activity.stub(:all).and_return(@activities)
  end

  step "I visit the main page" do
    visit '/'
  end

  step "I should see the dashboard" do
    page.should have_content 'Dashboard'
  end

  step 'I should see the activities: :names_list' do |names_list|
    names = Array.new names_list.split(',').map(&:strip)
    names.each do |name|
      page.should have_content name
    end
  end

# end