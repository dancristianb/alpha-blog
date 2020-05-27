class User < ApplicationRecord
  has_many :articles
  before_save { email.downcase! }


  validates :username, uniqueness: { case_sensitive: false },
            presence: true, length: { minimum: 3, maximum: 25 }
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, uniqueness: { case_sensitive: false },
            presence: true, length: { maximum: 105 },
            format: EMAIL_REGEX
end
