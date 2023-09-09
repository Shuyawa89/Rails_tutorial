class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      #ユーザページにリダイレクトする
      reset_session #ログインの直前にこれを行う
      log_in user
      redirect_to user
    else
      #エラーメッセージの表示
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destory
  end
end
