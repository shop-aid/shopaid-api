class MonetizeDonation < ActiveRecord::Migration[5.0]
  def change
    add_monetize :donations, :price
  end
end
