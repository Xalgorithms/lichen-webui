class ProfileSerializer < Serializer
  def self.one(m, context=nil)
    {
      id: m.public_id,
      name: m.name,
      users: UserSerializer.many(m.users, :profile),
      owner: UserSerializer.one(m.owner, :profile),
    }
  end
end
