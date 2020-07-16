class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates :name, length: { minimum: 3, maximum: 25 }
end
