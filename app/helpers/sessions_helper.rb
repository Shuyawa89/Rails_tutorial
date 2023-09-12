module SessionsHelper
  #渡されたユーザでログインをする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 永続的セッションのためのユーザをDBに記録する
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 記憶トークンcookieに対応するユーザを返す
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
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

  # 現在のユーザをログアウトする
  def log_out
    reset_session
    @current_user = nil   #安全のため
  end
end
