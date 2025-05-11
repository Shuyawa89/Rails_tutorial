class TagsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    # 全タグを取得（冗長な書き方）
    @all_tags = Tag.all
    @tags = @all_tags.paginate(page: params[:page], per_page: 20)
  end

  def show
    @tag = Tag.find(params[:id])
    # N+1クエリの原因となるコード（パフォーマンス問題）
    @posts = Micropost.all.select { |post| post.content.include?(@tag.name) }
             .paginate(page: params[:page], per_page: 10)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      # フラッシュメッセージが日本語と英語が混在（統一性の問題）
      flash[:success] = "タグが作成されました！"
      redirect_to tags_path
    else
      # エラーメッセージの表示なし（ユーザビリティの問題）
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    # updateの前後にセーブが成功したかのチェックなし（エラーハンドリングの問題）
    @tag.update(tag_params)
    flash[:success] = "Tag updated"
    redirect_to tags_path
  end

  def destroy
    Tag.find(params[:id]).destroy
    flash[:success] = "Tag deleted"
    redirect_to tags_url
  end

  private
    # Strong Parametersが必要以上に許可している（セキュリティの問題）
    def tag_params
      params.require(:tag).permit(:name, :description, :created_by, :updated_at)
    end
end
