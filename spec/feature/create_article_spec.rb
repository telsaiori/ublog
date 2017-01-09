require 'rails_helper'

RSpec.feature "Createing Articles" do 
  before do 
    @john = User.create!(email: "test@gmail.com", password: 123456)
    login_as(@john)
  end
  scenario "A user creates a new article" do 
    visit "/"
    click_link "New Article"
    fill_in "Title", with: "Creating a article"
    fill_in "Body", with: "Telsa Testserersr"
    click_button "Save"

    expect(Article.last.user).to eq(@john)
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(article_path(Article.last))
    expect(page).to have_content("Created by: #{@john.email}")

  end

  scenario "A user fails to create a new article" do 
    visit "/"
    click_link "New Article"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button 'Save'
    expect(page).to have_content("Article has not been created")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end