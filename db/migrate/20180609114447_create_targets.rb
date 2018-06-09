class CreateTargets < ActiveRecord::Migration[5.0]
  def change
    create_table :targets do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :cause, foreign_key: true

      t.timestamps
    end
  end
end
