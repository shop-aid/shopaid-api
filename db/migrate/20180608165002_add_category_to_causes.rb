class AddCategoryToCauses < ActiveRecord::Migration[5.0]
  def change
    add_column :causes, :category, :string
  end
end
