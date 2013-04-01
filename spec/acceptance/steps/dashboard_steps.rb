# module DashboardSteps
  step "I visit the main page" do
    visit '/'
  end
  step "I should see the dashboard" do
    page.should have_content 'Dashboard'
  end
# end