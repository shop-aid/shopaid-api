module Api
  module V1
    class TargetsController < ApplicationController
      layout false

      def index
        @targets = Target.all
      end
    end
  end
end
