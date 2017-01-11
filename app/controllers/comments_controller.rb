class CommentsController < ApplicationController
  before_action :set_article, only: [:create]
  before_action :comment_params, only: [:create]
  before_action :authenticate_user!
  
  def new
  end

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments",
        render(partial: 'comments/comment', object: @comment)      
        flash[:notice] = 'Comment has been created'
    else
      flash[:alert] = 'Comment has not been created'
    end
    # redirect_to article_path(@article)
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
