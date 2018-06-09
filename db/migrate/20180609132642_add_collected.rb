class AddCollected < ActiveRecord::Migration[5.0]
  def change
    add_monetize :projects, :collected
  end
end
