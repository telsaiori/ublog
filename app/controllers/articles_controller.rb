class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: "Article has been created"
    else
      flash.now[:warning] = 'Article has not been created'
      render 'new'
    end
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def resource_not_found
    message = "The article you are looking for could not be found"
    flash[:alert] = message
    redirect_to root_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
