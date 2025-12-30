class UsersController < ApplicationController
  skip_before_action :authorize_user!, only: :login
  before_action :authorize_admin!, except: [:login, :logout]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.order(:last_name, :first_name)
    @breadcrumbs = ['Users']
  end

  def show
    @breadcrumbs = [['Users', users_path], @user.name]
  end

  def new
    @user = User.new
  end

  def edit
    @breadcrumbs = [['Users', users_path], [@user.name, user_path(@user)], 'Edit']
  end

  def create
    @user = ItemCategory.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login
    session[:user_id] = params[:user_id]
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end