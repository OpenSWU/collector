class CreateArenas < ActiveRecord::Migration[8.0]
  def change
    create_table :arenas do |t|
      t.string :name
      t.text :description

      t.index :name, unique: true
    end
  end
end
