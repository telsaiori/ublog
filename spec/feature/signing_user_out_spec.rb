require "rails_helper"

RSpec.feature "Signing out signed-in users" do 
  before do 
    @john = User.create!(email: "test@gmail.com", password: 123456)
    visit "/"
    click_link 'Sign In'
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button 'Log in'
  end

  scenario "User sign out" do
    
    click_link 'Sign Out'
    expect(page).to have_content("Signed out successfully")
    expect(page).to_not have_content("Sign Out")
  end
end