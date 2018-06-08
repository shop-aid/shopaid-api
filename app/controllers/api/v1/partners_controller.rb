module Api
  module V1
    class PartnersController < ApplicationController
      layout false

      def index
        @partners = Partner.all
      end
    end
  end
end
