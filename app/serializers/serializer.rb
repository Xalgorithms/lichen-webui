class Serializer
  def self.many(ms, context=nil)
    ms.map { |m| one(m, context) }
  end
end
