class Users::RelationshipsController < ApplicationController
  def create
    current_user.active_relationships.create!(followed_id: params[:user_id])
    redirect_to request.referer || root_path
  end

  def destroy
    current_user.active_relationships.find_by(followed_id: params[:id]).destroy!
    redirect_to request.referer || root_path
  end
end
