class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #debugger #ここで動作を止めてコンソールからパラメータを見ることができる
  end

  def new
    @user = User.new
  end
end
