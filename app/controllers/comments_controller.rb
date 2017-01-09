class CommentsController < ApplicationController
  before_action :set_article, only: [:create]
  before_action :comment_params, only: [:create]
  
  def new
  end

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to article_path(@article), notice: 'Comment has been created'
    else
      flash.now[:alert] = 'Comment has not been created'
    end
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
