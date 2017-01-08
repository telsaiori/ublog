require "rails_helper"

RSpec.feature "delete article" do 
  before do 
    @john = User.create!(email: "test@gmail.com", password: 123456)
    @article = Article.create(title: "the first article", body: "test1")
  end

  scenario "user delete an article" do 
    visit "/"
    click_link @article.title
    click_link "Delete Article"
    
    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(root_path)
  end
end