json.extract! donation, :id, :user_id, :cause_id, :partner_id, :created_at, :updated_at
json.url donation_url(donation, format: :json)
