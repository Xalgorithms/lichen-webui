class Criterium
  include Mongoid::Document

  field :key, type: String
  field :value, type: String

  belongs_to :profile

  after_create do |m|
    ChangesService.added(m, [:key, :value])
  end
end
