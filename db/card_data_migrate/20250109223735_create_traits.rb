class CreateTraits < ActiveRecord::Migration[8.0]
  def change
    create_table :traits do |t|
      t.string :name
      t.text :description

      t.index :name, unique: true
    end
  end
end
