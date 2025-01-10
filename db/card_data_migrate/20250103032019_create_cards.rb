class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.integer :swuid
      t.integer :swu_cardid
      t.string :title
      t.string :subtitle
      t.integer :number
      t.string :set_code

      t.index %i[swuid swu_cardid], unique: true
      t.index :set_code
    end
  end
end
