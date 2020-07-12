class Category < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :name, length: { minimum: 3, maximum: 25 }
end
