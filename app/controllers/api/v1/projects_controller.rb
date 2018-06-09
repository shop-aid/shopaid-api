module Api
  module V1
    class ProjectsController < ApplicationController
      layout false

      def index
        @projects = Project.order(:sort).all
      end
    end
  end
end
