class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.references :food, foreign_key: true
      t.string :recipe_title, null: false
      t.string :body, null: false
      t.string :recipe_image, null: false

      t.timestamps
    end
  end
end
