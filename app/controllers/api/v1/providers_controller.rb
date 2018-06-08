module Api
  module V1
    class ProvidersController < ApplicationController
      layout false

      def index
        @providers = Provider.all
      end
    end
  end
end
