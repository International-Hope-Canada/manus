class UsersController < ApplicationController
  skip_before_action :authorize_user!, only: :login
  before_action :authorize_admin!, except: [ :login, :logout ]
  before_action :set_user, only: %i[show edit update]

  def index
    @pagy, @users = pagy(:offset, User.order(active: :desc, last_name: :asc, first_name: :asc))
    @breadcrumbs = [ "Users" ]
  end

  def show
    @breadcrumbs = [ [ "Users", users_path ], @user.name ]
  end

  def new
    @user = User.new
    @breadcrumbs = [ [ "Users", users_path ], "New" ]
    render :edit
  end

  def edit
    @breadcrumbs = [ [ "Users", users_path ], [ @user.name, user_path(@user) ], "Edit" ]
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        @breadcrumbs = [ "Users", "New" ]
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def login
    user = User.active.find_by(initials: params[:initials])
    if user
      session[:user_id] = user.id
    else
      flash[:alert] = "No user found with initials '#{params[:initials]}'"
    end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :initials, :admin, :picker, :packer, :active)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
