class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You are registered"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You've been updated"
      redirect_to @user
    else
      render @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You may not edit another users profile"
      redirect_to root_path
    end
  end
end
