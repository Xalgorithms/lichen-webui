class ProfilesController < ApplicationController
  def index
    @profiles = ProfileSerializer.many(current_user.profiles)
    @user = UserSerializer.one(current_user)
  end
end
