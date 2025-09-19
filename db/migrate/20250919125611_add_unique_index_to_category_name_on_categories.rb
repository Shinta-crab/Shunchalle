class AddUniqueIndexToCategoryNameOnCategories < ActiveRecord::Migration[7.2]
  def change
    add_index :categories, :category_name, unique: true
  end
end
