class CreateCauses < ActiveRecord::Migration[5.0]
  def change
    create_table :causes do |t|
      t.text :description
      t.string :name
      t.boolean :local
      t.boolean :favorite

      t.timestamps
    end
  end
end
