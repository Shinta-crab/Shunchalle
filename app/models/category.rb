class Category < ApplicationRecord
  validates :category_name, presence: true
  validates :icon, presence: true

  has_one :food, dependent: :destroy
end
