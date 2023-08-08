class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #ユーザページにリダイレクトする
    else
      #エラーメッセージの表示
      render 'new', status: :unprocessable_entity
    end
  end

  def destory

  end
end
