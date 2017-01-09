class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :update, :destroy]
  
  def index
    @articles = Article.all
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: "Article has been created"
    else
      flash.now[:warning] = 'Article has not been created'
      render 'new'
    end
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end

  def edit
    unless @article.user == current_user
      flash[:alert] = "You can only edit your own article."
      redirect_to root_path
    end
  end

  def update
    unless @article.user == current_user
      flash[:danger] = "You can only edit your own article."
      redirect_to root_path
    else
      if @article.update(article_params)
        redirect_to article_path(@article), notice: "Article has been updated"
      else
        flash.now[:alert] = "Article has not been updated"
        render 'edit'
      end
    end
  end

  def destroy
    unless @article.user == current_user
      redirect_to root_path, alert: "You can only delete your own article"
    else
       if @article.destroy
        redirect_to root_path, notice: "Article has been deleted"
       end
    end
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
