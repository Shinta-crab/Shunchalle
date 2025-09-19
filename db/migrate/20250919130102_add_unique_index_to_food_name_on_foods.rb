class AddUniqueIndexToFoodNameOnFoods < ActiveRecord::Migration[7.2]
  def change
    add_index :foods, :food_name, unique: true
  end
end
