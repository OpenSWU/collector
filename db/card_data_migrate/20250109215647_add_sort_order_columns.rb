class AddSortOrderColumns < ActiveRecord::Migration[8.0]
  def change
    add_column :aspects, :sort_order, :integer
    add_column :expansions, :sort_order, :integer
  end
end
