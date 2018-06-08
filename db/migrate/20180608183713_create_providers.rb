class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.boolean :implemented

      t.timestamps
    end
  end
end
