class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      #ユーザページにリダイレクトする
      forwarding_url = session[:forwarding_url]
      reset_session #ログインの直前にこれを行う
      remember @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to forwarding_url || @user
    else
      #エラーメッセージの表示
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destory
    log_out if logged_in?
    redirect_to root_url, status: :see_other  #HTTPステータスを指定
  end


end
