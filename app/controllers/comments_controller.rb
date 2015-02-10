class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
      flash[:notice] = "Thanks for commenting"
    else
      flash[:errors] = "Commenting requires that you...comment"
      redirect_to :back
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    
    respond_to do |format|

      format.html do
        if @vote.valid?
          flash[:notice] = "That's a vote!"
        else
          flash[:error] = "Um, looks like you voted on that"
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
  def comments_params
    params.require(:comment).permit(:body, :post_id)
  end
end
