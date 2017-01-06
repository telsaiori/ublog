require 'rails_helper'

RSpec.feature "Showing an article" do
  before do 
    @article = Article.create(title: "the first article", body: "test1")
  end

  scenario "User click the article title to display article" do 
    visit "/"
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end


end 

