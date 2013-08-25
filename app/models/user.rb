class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true

  has_many :permissions

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
