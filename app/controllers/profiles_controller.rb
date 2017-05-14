class ProfilesController < ApplicationController
  before_filter :serialize_user
  
  def index
    @profiles = ProfileSerializer.many(current_user.profiles)
  end

  def show
    @profile = ProfileSerializer.one(Profile.where(public_id: params['id']).first)
  end

  def serialize_user
    @user = UserSerializer.one(current_user)
  end
end
