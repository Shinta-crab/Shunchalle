class CreateSearchSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :search_sessions do |t|
      t.text :foods_ids

      t.timestamps
    end
  end
end
