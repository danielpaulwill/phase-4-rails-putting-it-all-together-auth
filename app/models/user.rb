class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: { case_sensitive: true }
  validates :username, presence: true, uniqueness: true
  has_many :recipes
end
