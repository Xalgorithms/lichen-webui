class CriteriumSerializer < Serializer
  def self.one(m, context=nil)
    {
      key: m.key,
      value: m.value,
    }.tap do |o|
      if :profile != context
        o[:profiles] = ProfileSerializer.many(m.profiles, :criterium)
      end
    end
  end
end
