class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #debugger #ここで動作を止めてコンソールからパラメータを見ることができる
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      #成功した場合の処理
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity     
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #更新に成功した時の処理
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
