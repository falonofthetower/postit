class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    binding.pry
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    
    if @vote.valid?
      flash[:notice] = "That's a vote!"
    else
      flash[:error] = "Um, looks like you voted on that"
    end

    redirect_to :back
  end

  private
  def comments_params
    params.require(:comment).permit(:body, :post_id)
  end
end
