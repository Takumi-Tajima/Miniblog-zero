class Users::FollowingPostsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.followig_ids).default_order
  end
end
