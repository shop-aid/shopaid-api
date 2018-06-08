class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :cause
  belongs_to :partner

  monetize :price_cents
end
