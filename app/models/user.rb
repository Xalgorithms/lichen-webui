class User
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  field :fullname, type: String, default: nil

  # database_authenticatable
  field :email,    type: String, default: nil
  field :encrypted_password, type: String, default: nil
  
  validates_uniqueness_of :email, case_sensitive: false

  # :rememberable
  field :remember_created_at, :type => Time

  # :trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  # def initialize(*args)
  #   super(*args)
  #   self.public_id ||= UUID.generate
  # end
end
