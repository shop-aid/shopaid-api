include MoneyRails::ActionViewExtension

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :donations

  def charity_balance
    total = self.donations.inject(0) { |sum, donation| sum + donation.price_cents }
    humanized_money_with_symbol(Money.new(total, 'EUR'))
  end
end
