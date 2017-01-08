require "rails_helper"

RSpec.feature "User Signin" do 

  before do 
    @john = User.create!(email: "test@gmail.com", password: 123456)
  end

  scenario "with valid credential" do 
    visit "/"
    click_link 'Sign In'
    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).to_not have_link('Sign In')
    expect(page).to_not have_link('Sign Up')
  end
end