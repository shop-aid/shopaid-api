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

    puts resp_json["transactions"].each { |transaction|
      details = transaction["details"]
      Transaction.delete_all
      Transaction.create(
        description: details["description"],
        new_balance: details["new_balance"]["amount"].to_f,
        value: details["value"]["amount"].to_f,
      )
    }
  end

  desc "Seed transactions"
  task seed: :environment do
    # Config
    base = "https://beyondbanking.openbankproject.com"
    bank_id = "bb.02.nlbb.nlbb"
    account_id = "Dunya"
    view_id = "owner"

    descs = [
      "AH.nl", "Coolblue.nl", "Thuisbezorgd.nl", "Mediamarkt.nl", "Hema.nl",
      "Booking.com", "Nike.com", "deBijenkorf.nl", "Blokker.nl", "Bol.com"
    ]

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

    # Create Transactions
    50.times do
      uri = URI.parse("#{base}/obp/v2.1.0/banks/#{bank_id}/accounts/#{account_id}/#{view_id}/transaction-request-types/SANDBOX_TAN/transaction-requests")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, {
        'Content-Type': 'application/json',
        'Authorization': "DirectLogin token=\"#{token}\""
      })
      body = {
        to: {
          bank_id: bank_id,
          account_id: account_id
        },
        value: {
          currency: "EUR",
          amount: rand(1000).to_s
        },
        description: descs.sample
      }
      request.body = body.to_json
      response = http.request(request)
      resp_json = JSON.parse(response.body)
      puts resp_json
    end
  end

  desc "Create view"
  task view: :environment do
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

    # 2 Create view
    uri = URI.parse("#{base}/obp/v3.0.0/banks/#{bank_id}/accounts/#{account_id}/views")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    body =
      {
        name: "Shopaid",
        description: "This view is for Shopaid",
        is_public: true,
        which_alias_to_use: "Shopaid",
        hide_metadata_if_alias_used: false,
        allowed_actions: [
          "can_see_transaction_this_bank_account",
          "can_see_transaction_other_bank_account",
          "can_see_transaction_metadata",
          "can_see_transaction_label",
          "can_see_transaction_amount",
          "can_see_transaction_type",
          "can_see_transaction_currency",
          "can_see_transaction_start_date",
          "can_see_transaction_finish_date",
          "can_see_transaction_balance",
          "can_see_comments",
          "can_see_narrative",
          "can_see_tags",
          "can_see_images",
          "can_see_bank_account_owners",
          "can_see_bank_account_type",
          "can_see_bank_account_balance",
          "can_see_bank_account_currency",
          "can_see_bank_account_label",
          "can_see_bank_account_national_identifier",
          "can_see_bank_account_swift_bic",
          "can_see_bank_account_iban",
          "can_see_bank_account_number",
          "can_see_bank_account_bank_name",
          "can_see_other_account_national_identifier",
          "can_see_other_account_swift_bic",
          "can_see_other_account_iban",
          "can_see_other_account_bank_name",
          "can_see_other_account_number",
          "can_see_other_account_metadata",
          "can_see_other_account_kind",
          "can_see_more_info",
          "can_see_url",
          "can_see_image_url",
          "can_see_open_corporates_url",
          "can_see_corporate_location",
          "can_see_physical_location",
          "can_see_public_alias",
          "can_see_private_alias",
          "can_add_more_info",
          "can_add_url",
          "can_add_image_url",
          "can_add_open_corporates_url",
          "can_add_corporate_location",
          "can_add_physical_location",
          "can_add_public_alias",
          "can_add_private_alias",
          "can_delete_corporate_location",
          "can_delete_physical_location",
          "can_edit_narrative",
          "can_add_comment",
          "can_delete_comment",
          "can_add_tag",
          "can_delete_tag",
          "can_add_image",
          "can_delete_image",
          "can_add_where_tag",
          "can_see_where_tag",
          "can_delete_where_tag",
          "can_create_counterparty",
          "can_see_bank_routing_scheme",
          "can_see_bank_routing_address",
          "can_see_bank_account_routing_scheme",
          "can_see_bank_account_routing_address",
          "can_see_other_bank_routing_scheme",
          "can_see_other_bank_routing_address",
          "can_see_other_account_routing_scheme",
          "can_see_other_account_routing_addres"
        ]
      }
    request = Net::HTTP::Get.new(uri.request_uri, {
      'Content-Type': 'application/json',
      'Authorization': "DirectLogin token=\"#{token}\""
    })
    request.body = body.to_json
    response = http.request(request)
    resp_json = JSON.parse(response.body)

    puts resp_json
  end

  desc "Get Views"
  task get_views: :environment do
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

    # Get Views
    uri = URI.parse("#{base}/obp/v3.0.0/banks/#{bank_id}/accounts/#{account_id}/views")
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

  desc "Create counterparty"
  task create_counterparty: :environment do
    # Config
    base = "https://beyondbanking.openbankproject.com"
    bank_id = "bb.02.nlbb.nlbb"
    account_id = "Dunya"
    view_id = "owner"

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

    # Create counterparty
    uri = URI.parse("#{base}/obp/v2.2.0/banks/#{bank_id}/accounts/#{account_id}/#{view_id}/counterparties")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, {
      'Content-Type': 'application/json',
      'Authorization': "DirectLogin token=\"#{token}\""
    })
    body = {
      name:"CounterpartyName",
      description:"My landlord",
      other_account_routing_scheme:"accountNumber",
      other_account_routing_address:"7987987-2348987-234234",
      other_account_secondary_routing_scheme:"IBAN",
      other_account_secondary_routing_address:"DE89370400440532013000",
      other_bank_routing_scheme:"bankCode",
      other_bank_routing_address:bank_id,
      other_branch_routing_scheme:"branchNumber",
      other_branch_routing_address:"10010",
      is_beneficiary:true,
      bespoke: [
        {
          key:"englishName",
          value:"english Name"
        }
      ]
    }
    request.body = body.to_json
    response = http.request(request)
    resp_json = JSON.parse(response.body)
    puts resp_json
  end
end
