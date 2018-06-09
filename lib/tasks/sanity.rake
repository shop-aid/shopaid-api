require 'net/http'
require 'uri'
require 'json'

namespace :sanity do
  desc "Do a sanity check"
  task check: :environment do
    # Config
    base = "https://beyondbanking.openbankproject.com"
    bank_id = "bb.02.nlbb.nlbb"
    account_id = "Dunya"

    # 1 Direct Login
    uri = URI.parse("#{base}/my/logins/direct")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, {
      'Content-Type': 'application/json',
      'Authorization': 'DirectLogin username="dunyakirkali", password="dunya386925Ban!", consumer_key="qzkjjiaevtsnf2wx221afyfzr1q405nygkl2l4vx"'
    })
    response = http.request(request)
    resp_json = JSON.parse(response.body)
    token = resp_json["token"]

    # 2 Get Transactions
    uri = URI.parse("#{base}/obp/v3.0.0/my/banks/#{bank_id}/accounts/#{account_id}/transactions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, {
      'Content-Type': 'application/json',
      'Authorization': "DirectLogin token=\"#{token}\""
    })
    response = http.request(request)
    resp_json = JSON.parse(response.body)

    puts resp_json
  end
end
