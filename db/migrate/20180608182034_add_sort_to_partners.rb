class AddSortToPartners < ActiveRecord::Migration[5.0]
  def change
    add_column :partners, :sort, :integer
  end
end
