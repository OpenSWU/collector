class CreateCardSearchTable < ActiveRecord::Migration[8.0]
  def change
    create_virtual_table :card_search, :fts5, [ "title", "subtitle", "set_code" ]
  end
end
