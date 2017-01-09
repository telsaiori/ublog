require 'rails_helper'

RSpec.describe "Articles", type: :request do 
  before do 
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create!(title: "the first article", body: "test1", user: @john)
  end

  describe "GET /articles/:id/edit" do 
    context 'with non-signed in user' do
        before { get "/articles/#{@article.id}/edit" } 
      
      it "redirect to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user who is not owner' do 
      before do 
        login_as @fred
        get "/articles/#{@article.id}/edit" 
      end
      
      it "redirect to the homepage" do 
        expect(response.status).to eq 302
        flash_message = "You can only edit your own article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "with signed in user as owner successful edit" do 
      before do 
        login_as @john
        get "/articles/#{@article.id}/edit" 
      end

      it "successfully edits articles" do 
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET /articles/:id' do 
    context 'with existing article' do 
      before { get "/articles/#{@article.id}" }

      it "handles existing article" do 
        expect(response.status).to eq 200
      end

      context "with non-existing article" do 
        before { get "/articles/xxx" }

        it "handles non-existing article" do 
          expect(response.status).to eq 302
          flash_message = "The article you are looking for could not be found"
          expect(flash[:alert]).to eq flash_message
        end
      end
    end
  end

  describe 'DELETE /articles/:id/' do 
    context "with signin user as a owner successful delete" do 
      before do 
        login_as @john
        delete "/articles/#{@article.id}/"
      end
      
      it "successfully delete the article" do 
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq "Article has been deleted"
      end
    end

    context "with signed in user who is not the owner" do 
      before do 
        login_as @fred
        delete "/articles/#{@article.id}/"
      end

      it "redirect to homepage" do 
        expect(response.status).to eq 302
        flash_message = "You can only delete your own article"
        expect(flash[:alert]).to eq flash_message
      end
    end
  end

end