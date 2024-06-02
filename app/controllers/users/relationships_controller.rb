class Users::RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user])
    redirect_to request.referer || root_path
  end

  def destroy
    current_user.unfollow!(params[:user])
    redirect_to request.referer || root_path
  end
end
