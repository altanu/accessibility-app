module Api
  module V2
    class ReviewsController < ApplicationController
      before_action :set_review, only: [:show, :update, :destroy]

      # GET /reviews

      def index
        @reference = params[:user_id] ? User.find(params[:user_id]) : Location.find(params[:location_id])
        @reviews = @reference.reviews.sort{ |b, a| a.created_at <=> b.created_at }

        render json: @reviews
      end

      # GET /reviews/1
      def show
        @reference = params[:user_id] ? User.find(params[:user_id]) : Location.find(params[:location_id])
        @review = @reference.reviews.find(params[:id])
        render json: @review
      end

      # POST /reviews
      def create
        @review = Review.new(review_params)

        if @review.save
          render json: @review, status: :created, location: api_v2_location_reviews_url(@review)
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /reviews/1
      def update
        if @review.update(review_params)
          render json: @review
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      # DELETE /reviews/1
      def destroy
        @review.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_review
          @review = Review.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def review_params
          params.require(:review).permit(:user_id, :location_id, :wheel_chair, :description, :rating)
        end
    end
  end
end

