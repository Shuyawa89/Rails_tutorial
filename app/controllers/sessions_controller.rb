class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      #ユーザページにリダイレクトする
      reset_session #ログインの直前にこれを行う
      remember user
      log_in user
      redirect_to user
    else
      #エラーメッセージの表示
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destory
    log_out
    redirect_to root_url, status: :see_other  #HTTPステータスを指定
  end


end
