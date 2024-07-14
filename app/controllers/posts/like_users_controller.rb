class Posts::LikeUsersController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    @liked_users = post.liked_users
  end
end
