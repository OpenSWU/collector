class CreateExpansions < ActiveRecord::Migration[8.0]
  def change
    create_table :expansions do |t|
      t.string :code
      t.string :title
      t.date :released_on

      t.index :code, unique: true
    end
  end
end
