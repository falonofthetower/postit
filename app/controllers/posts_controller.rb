class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :set_categories, only: [:index, :new, :update, :edit]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator, only: [:edit, :update]

  helper_method :creator?
  def index    
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse

    respond_to do |format|
      format.json { render json: @posts }
      format.html
    end
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

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Thanks for voting"
        else
          flash[:error] = "You can only vote once"
        end
        
        redirect_to :back
      end
      
      format.js
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated!"
      redirect_to @post
    else
      flash.now[:error] = "Something went wrong!"
      render 'edit'
    end
  end

  def creator?
    current_user == @post.creator || current_user.admin?
  end

  private
    def post_params
      params.require(:post).permit(:title, :description, :url, category_ids: [])
    end

    def set_post
      @post = Post.find_by_slug!(params[:id])
    end

    def set_categories
      @categories = Category.all
    end

    def require_creator
      access_denied unless logged_in? and creator? 
    end
end
