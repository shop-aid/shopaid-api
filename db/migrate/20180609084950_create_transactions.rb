class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :description

      t.timestamps
    end
    add_monetize :transactions, :new_balance
    add_monetize :transactions, :value
  end
end
