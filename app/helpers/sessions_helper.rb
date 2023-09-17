module SessionsHelper
  #渡されたユーザでログインをする
  def log_in(user)
    session[:user_id] = user.id
    # セッションリプレイ攻撃から保護する
    # 詳しくは https://techracho.bpsinc.jp/hachi8833/2023_06_02/130443 を参照
    session[:session_token] = user.session_token()
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
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token()
        @current_user = user
      end
      # @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      #raise       # テストがパスすれば、この部分がテストされていないことがわかる
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 渡されたユーザがログイン中のユーザであればtrueを返す
  def current_user?(user)
    user && user == current_user
  end

  # #ログイン中のユーザを返すメソッド(いない場合nil)
  # def current_user
  #   if session[:user_id]
  #     @current_user ||= User.find_by(id: session[:user_id])
  #   end
  # end

  #ユーザがログイン中かを判断するメソッド
  def logged_in?
    !current_user.nil?
  end

  #永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザをログアウトする
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil   #安全のため
  end
end

# アクセスしようとしたURLを覚えておく
def store_location
  session[:forwarding_url] = request.original_url if request.get?
end
