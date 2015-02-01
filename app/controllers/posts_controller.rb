class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :set_categories, only: [:index, :new, :update, :edit]
  before_action :require_user, except: [:show, :index]
  def index    
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end
  
  def show    
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.creator_id = @current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])


    if @vote.valid?
      flash[:notice] = "Thanks for voting"
    else
      flash[:error] = "Something went wrong with your vote"
    end

    redirect_to :back
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :description, :url, category_ids: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end
end
