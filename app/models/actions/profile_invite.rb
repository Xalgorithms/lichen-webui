module Actions
  class ProfileInvite < Action
    field :email, type: String
    field :profile_id, type: String
  end
end
