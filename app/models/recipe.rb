class Recipe < ApplicationRecord
  validates :recipe_title, presence: true
  validates :recipe_image, presence: true
  validates :body, presence: true

  belongs_to :food
end
