module Api
  module V1
    class PartnersController < ApplicationController
      layout false

      def index
        @partners = Partner.order(:sort).all
      end
    end
  end
end
