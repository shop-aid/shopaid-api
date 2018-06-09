module Api
  module V1
    module Backdoor
      class PartnersController < ApplicationController
        layout false

        skip_before_action :verify_authenticity_token

        def record
          user = User.first
          causes = user.causes
          partner = Partner.first
          percentage = partner.percentage
          price = /€ (.*)/.match(params[:price])[1].to_f
          donation = price * percentage
          causes.each do |cause|
            Donation.create(user: user, cause: cause, partner: partner, price: donation.to_f / causes.count)
          end
        end
      end
    end
  end
end
