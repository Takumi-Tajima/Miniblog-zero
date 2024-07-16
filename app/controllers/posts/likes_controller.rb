class Posts::LikesController < ApplicationController
  def index
  end

  def create
    @like = current_user.likes.build(post_id: params[:post_id])
    @like.save!
    redirect_to request.referer || root_path
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:post_id])
    @like.destroy!
    redirect_to request.referer || root_path
  end
end
