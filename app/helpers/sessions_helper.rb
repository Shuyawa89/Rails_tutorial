module SessionsHelper
  #渡されたユーザでログインをする
  def log_in(user)
    session[:user_id] = user.id
  end

  #ログイン中のユーザを返すメソッド(いない場合nil)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #ユーザがログイン中かを判断するメソッド
  def logged_in?
    !current_user.nil?
  end
end
