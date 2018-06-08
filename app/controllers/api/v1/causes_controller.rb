module Api
  module V1
    class CausesController < ApplicationController
      layout false

      def index
        @causes = Cause.order(:sort).all
      end
    end
  end
end
