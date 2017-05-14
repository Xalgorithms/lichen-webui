class UserSerializer < Serializer
  def self.one(m, context=nil)
    {
      id: m.public_id,
      name: m.fullname,
      email: m.email,
    }.tap do |o|
      if !context
        o[:profiles] = ProfileSerializer.many(m.profiles, :user)
      end
    end
  end
end
