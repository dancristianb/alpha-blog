class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up!"
      redirect_to articles_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information has been successfully updated!"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = 'Account and articles deleted!'
    redirect_to articles_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    unless current_user == @user || current_user.admin?
      flash[:alert] = 'You can only edit or delete your own account!'
      redirect_to users_path
    end
  end
end
