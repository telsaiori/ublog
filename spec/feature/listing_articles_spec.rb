require 'rails_helper'

RSpec.feature "Listing articles" do 
  
  before do 
    @john = User.create!(email: "test@gmail.com", password: 123456)
    @article1 = Article.create(title: "the first article", body: "test1", user: @john)

    @article2 = Article.create(title: "the second article", body: "test2", user: @john)
  end
  
  scenario "with articles created and user not signed in" do 
    visit "/"
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "with articles created and user signed in" do 
    login_as(@john)
    Article.delete_all
    visit "/"
    expect(page).to_not have_content(@article1.title)
    expect(page).to_not have_content(@article1.body)
    expect(page).to_not have_content(@article2.title)
    expect(page).to_not have_content(@article2.body)
    expect(page).to_not have_link(@article1.title)
    expect(page).to_not have_link(@article2.title)
    expect(page).to have_link("New Article")

    within("h1#no-articles") do 
      expect(page).to have_content("No articles created")
    end
  end
end