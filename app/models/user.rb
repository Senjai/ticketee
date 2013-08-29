class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true

  has_many :permissions
  has_many :comments

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
