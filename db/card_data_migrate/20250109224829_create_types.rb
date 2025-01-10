class CreateTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :types do |t|
      t.string :name
      t.text :description
      t.integer :sort_order

      t.index :name, unique: true
    end
  end
end
