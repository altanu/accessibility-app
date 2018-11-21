module Api
  module V2
    class PlacesController < ApplicationController
      before_action :set_place, only: [:show]

      # GET /places/:id
      def show
        render json: @place
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_place
          @place = Location.where(place_id: params[:id])
        end
    end
  end
end
