module Actions
  class ProfileAdd < Action
    field :name, type: String
    field :owner_id, type: String
  end
end
