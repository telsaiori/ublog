require "rails_helper"

RSpec.feature "Add comments to articles" do 
  before do 
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create!(title: "the first article", body: "test1", user: @john)
  end

  scenario "permits a signed in user to write a comment" do 
    login_as @fred
    visit"/"
    click_link @article.title
    fill_in "New Comment", with: 'Amazing article'
    click_button 'Add Comment'

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("Amazing article")
    expect(current_path).to eq(article_path(Article.last))
  end


end