class Profile
  include Mongoid::Document

  field :name, type: String
  field :public_id, type: String

  has_and_belongs_to_many :users, inverse_of: :profiles
  belongs_to :owner, class_name: 'User', inverse_of: :owns

  def initialize(*args)
    super(*args)
    self.public_id ||= UUID.generate
  end

  after_destroy do |m|
    ChangesService.destroyed(m)
  end
end
