class ChangeCards < ActiveRecord::Migration[8.0]
  def change
    add_column :cards, :artist, :string
    add_column :cards, :url, :string
  end
end
