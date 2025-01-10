class CreateRarities < ActiveRecord::Migration[8.0]
  def change
    create_table :rarities do |t|
      t.string :name
      t.string :character
      t.string :color
      t.integer :sort_order

      t.index :name, unique: true
    end
  end
end
