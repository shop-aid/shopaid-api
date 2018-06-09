class Transaction < ApplicationRecord
    monetize :new_balance_cents
    monetize :value_cents
end
