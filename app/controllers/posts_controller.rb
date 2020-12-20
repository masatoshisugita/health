class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy graph]
  skip_before_action :login_required

  def index
    if current_user.nil?
      redirect_to login_url
    end
    @posts = Post.all.includes(:user).order(created_at: "DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "投稿を作成しました"
      redirect_to root_url
    else
      flash[:danger] = "ユーザーの編集に失敗しました"
      render :new
    end
  end

  def show
    height = @post.user.height / 100
    @bmi = (@post.weight / ( height ** 2)).round(1)
    @motion_time = @post.motion_time
    @sleep_time = @post.sleep_time
    @graph = Post.where(user_id: @post.user_id )

    @graph_weight = @graph.pluck(:created_at,:weight)
    @graph_weight.each do |g|
      g[0] = g[0].strftime("%Y年%m月%d日")
    end

    @graph_sleep = @graph.pluck(:created_at,:sleep_time)
    @graph_sleep.each do |g|
      g[0] = g[0].strftime("%Y年%m月%d日")
    end

    @graph_motion = @graph.pluck(:created_at,:motion_time)
    @graph_motion.each do |g|
      g[0] = g[0].strftime("%Y年%m月%d日")
    end
  end

  def edit; end

  def graph
    @graph = Post.where(user_id: @post.user_id )

    @graph_weight = @graph.pluck(:created_at,:weight)
    @graph_weight.each do |g|
      g[0] = g[0].strftime("%Y年%m月%d日")
    end

    @graph_sleep = @graph.pluck(:created_at,:sleep_time)
    @graph_sleep.each do |g|
      g[0] = g[0].strftime("%Y年%m月%d日")
    end

    @graph_motion = @graph.pluck(:created_at,:motion_time)
    @graph_motion.each do |g|
      g[0] = g[0].strftime("%Y年%m月%d日")
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:weight,:bmi,:sleep_time,:motion_name,:motion_time,:detail)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
