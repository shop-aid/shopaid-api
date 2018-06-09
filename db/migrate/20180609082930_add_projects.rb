class AddProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.text :description
      t.string :name
      t.boolean :local
      t.boolean :favorite
      t.attachment :logo
      t.attachment :poster
      t.integer :sort
      t.string   :category
      t.timestamps
    end
  end
end
