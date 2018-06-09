json.extract! transaction, :id, :type, :description, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
