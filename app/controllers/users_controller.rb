class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update]
  skip_before_action :login_required, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーが作成されました"
      redirect_to root_url
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザーを編集しました"
      redirect_to @user
    else
      flash[:danger] = "ユーザーの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "ユーザー「#{@user.name}」を削除しました。"
    redirect_to root_url
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:age,:email,:password,:password_confirmation,:image,:height)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    if current_user != User.find(params[:id])
      flash[:danger] = 'こちらのURLにはアクセスできません。'
      redirect_to root_url
    end
  end

end
