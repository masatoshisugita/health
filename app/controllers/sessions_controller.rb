class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
    if current_user
      flash[:danger] = 'こちらのURLにはアクセスするには、ログアウトが必要です。'
      redirect_to root_url
    end
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
        log_in(user)
        flash[:info] = 'ログインしました'
        redirect_to user
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    reset_session
    flash[:info] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
