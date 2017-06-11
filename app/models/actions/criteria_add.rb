module Actions
  class CriteriaAdd < Action
    field :profile_id, type: String
    field :key, type: String
    field :value, type: String
  end
end
