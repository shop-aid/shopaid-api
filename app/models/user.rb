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

  def partner_breakdown
    Partner.all.map do |partner|
      total = self.donations.where(partner: partner).inject(0) { |sum, donation| sum + donation.price_cents }
      {
        name: partner.name,
        amount: humanized_money_with_symbol(Money.new(total, 'EUR'))
      }
    end
  end

  def cause_breakdown
    Cause.all.map do |cause|
      grand_total = self.donations.inject(0) { |sum, donation| sum + donation.price_cents }
      total = self.donations.where(cause: cause).inject(0) { |sum, donation| sum + donation.price_cents }
      {
        id: cause.id,
        name: cause.name,
        amount: humanized_money_with_symbol(Money.new(total, 'EUR')),
        percentage: grand_total.to_i == 0 ? 0 : (total.to_f / grand_total.to_f).to_i
      }
    end
  end
end
