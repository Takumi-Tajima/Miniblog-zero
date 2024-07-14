class Posts::LikesController < ApplicationController
  def index
  end

  def create
    current_user.likes.create!(post_id: params[:post_id])
    redirect_to request.referer || root_path
  end

  def destroy
    current_user.likes.find_by(post_id: params[:post_id]).destroy!
    redirect_to request.referer || root_path
  end
end
