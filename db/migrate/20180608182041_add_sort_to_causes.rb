class AddSortToCauses < ActiveRecord::Migration[5.0]
  def change
    add_column :causes, :sort, :integer
  end
end
