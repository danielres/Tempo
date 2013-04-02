

# module DashboardSteps

  step "activities: :words_list" do |words_list|
    names      = extract_words_from words_list
    activities = []
    names.each{ |name| activities  << Activity.new( name: name ) }
    Activity.stub(:all).and_return activities
  end

  step "I visit the main page" do
    visit '/'
  end

  step "I should see the dashboard" do
    page.should have_content 'Dashboard'
  end

  step 'I should see the activities: :words_list' do |words_list|
    names = extract_words_from words_list
    names.each{ |name| page.should have_content name}
  end

# end