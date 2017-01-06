require "rails_helper"

RSpec.feature "Signup users" do
  scenario "with valid credentials" do 
    visit "/"
    click_link 'Sign Up'
    fill_in "Email", with: "user@ex.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button 'Sign up'

    expect(page).to have_content("You have signed up successfully.")
  end 

  scenario "with invalid credentials" do 
    visit "/"
    click_link 'Sign Up'
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button 'Sign up'

    expect(page).to have_content("prohibited this user from being saved")
  end 
end