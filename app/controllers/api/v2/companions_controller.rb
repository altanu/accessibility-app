module Api
  module V2

    class CompanionsController < ApplicationController
      before_action :set_companion, only: [:show, :update, :destroy]

      # GET /companions
      def index
        @companions = Companion.all

        render json: @companions
      end

      # GET /companions/1
      def show
        render json: @companion
      end

      # POST /companions
      def create
        @companion = Companion.new(companion_params)

        if @companion.save
          render json: @companion, status: :created, location: @companion
        else
          render json: @companion.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /companions/1
      def update
        if @companion.update(companion_params)
          render json: @companion
        else
          render json: @companion.errors, status: :unprocessable_entity
        end
      end

      # DELETE /companions/1
      def destroy
        @companion.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_companion
          @companion = Companion.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def companion_params
          params.require(:companion).permit(:trip_id, :contact_id, :name, :email, :phone_number)
        end
    end
  end
end
