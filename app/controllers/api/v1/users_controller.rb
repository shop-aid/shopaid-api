module Api
  module V1
    class UsersController < ApplicationController
      layout false

      def show
        @user = User.first
      end
    end
  end
end
