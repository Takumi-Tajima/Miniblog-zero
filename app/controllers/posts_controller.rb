class PostsController < ApplicationController
  before_action :set_post, only: %i[show]
  skip_before_action :authenticate_user!

  def index
    @posts = Post.default_order.preload(likes: :user, user: :followers)
  end

  def show; end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
