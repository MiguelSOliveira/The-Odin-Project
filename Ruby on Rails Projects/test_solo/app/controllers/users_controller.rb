class UsersController < ApplicationController
  before_action :set_user, except: [:index, :create, :new]
  before_action :set_users, only: [:destroy]

  def show
  end

  def destroy
    @user.destroy
    @users = User.all
    render :index
  end

  def edit
    render :new
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_users
    @users = User.all
  end
end
