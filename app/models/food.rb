class Food < ApplicationRecord
  validetes :food_name, presence: true
  validates :start_week, presence: true
  validates :end_week, presence: true
  validates :is_rare, presence: true

  belongs_to :category
end
