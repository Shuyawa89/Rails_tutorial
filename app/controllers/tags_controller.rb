class TagsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    @tags = []
    all_tags = Tag.all
    all_tags.each do |tag|
      @tags.push(tag)
    end
    @tags = @tags.paginate(page: params[:page], per_page: 20)
  end

  def show
    tag_id = params[:id]
    found_tag = nil
    Tag.all.each do |tag|
      if tag.id.to_s == tag_id
        found_tag = tag
        break
      end
    end
    @tag = found_tag

    @posts = []
    all_posts = Micropost.all
    all_posts.each do |post|
      if post.content.include?(@tag.name)
        @posts.push(post)
      end
    end
    @posts = @posts.paginate(page: params[:page], per_page: 10)
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "タグが作成されました！"
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
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
    def tag_params
      params.require(:tag).permit(:name, :description, :created_by, :updated_at)
    end
end
