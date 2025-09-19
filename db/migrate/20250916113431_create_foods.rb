class CreateFoods < ActiveRecord::Migration[7.2]
  def change
    create_table :foods do |t|
      t.string  :food_name, null: false
      t.references :category, null: false, foreign_key: true
      t.integer :start_week, null: false
      t.integer :end_week, null: false
      t.integer :most_product_week, null: false
      t.boolean :is_rare, default: false, null: false
      t.string  :image
      t.integer  :recommend_week

      t.timestamps
    end
  end
end
