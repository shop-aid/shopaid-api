include MoneyRails::ActionViewExtension

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :donations
  has_many :causes, through: :targets
  has_many :targets

  def charity_balance
    total = self.donations.inject(0) { |sum, donation| sum + donation.price_cents }
    humanized_money_with_symbol(Money.new(total, 'EUR'))
  end

  def grand_total
    donations.inject(0) { |sum, donation| sum + donation.price_cents }
  end

  def partner_breakdown
    Partner.all.map do |partner|
      total = self.donations.where(partner: partner).inject(0) { |sum, donation| sum + donation.price_cents }
      next if total == 0
      {
        name: partner.name,
        amount: humanized_money_with_symbol(Money.new(total, 'EUR')),
        percentage: grand_total.to_i == 0 ? 0 : ((total.to_f / grand_total.to_f) * 100).to_i
      }
    end.compact.sort_by { |hsh| hsh[:percentage] }.reverse
  end

  def cause_breakdown
    causes.map do |cause|
      total = self.donations.where(cause: cause).inject(0) { |sum, donation| sum + donation.price_cents }
      {
        id: cause.id,
        name: cause.name,
        amount: humanized_money_with_symbol(Money.new(total, 'EUR')),
        percentage: grand_total.to_i == 0 ? 0 : ((total.to_f / grand_total.to_f) * 100).to_i
      }
    end
  end
end
