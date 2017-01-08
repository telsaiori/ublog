require "rails_helper"

RSpec.feature "Editing an article" do 
  before do 
    @john = User.create!(email: "test@gmail.com", password: 123456)
    @article = Article.create(title: "the first article", body: "test1")
  end

  scenario "A user updates an article" do 
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: "Updated title"
    fill_in "Body", with: "Updated body"
    click_button "Save"
    
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content("Article has been updated")
  end

  scenario "A user fails to updates an article" do 
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Save"
    
    expect(page.current_path).to eq(article_path(@article))
    expect(page).to have_content("Article has not been updated")
  end
  
end