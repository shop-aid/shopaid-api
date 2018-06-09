module Api
  module V1
    module Backdoor
      class PartnersController < ApplicationController
        layout false

        skip_before_action :verify_authenticity_token

        def record
          user = User.first
          cause = Cause.first
          partner = Partner.first
          price = /€ (.*)/.match(params[:price])[1].to_f
          Donation.create(user: user, cause: cause, partner: partner, price: price * 0.1)
        end
      end
    end
  end
end
