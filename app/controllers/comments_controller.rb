class CommentsController < ApplicationController
  def create
#    binding.pry
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private
  def comments_params
    params.require(:comment).permit(:body, :post_id)
  end
end
