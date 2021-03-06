module Api
  module V2

    class TripsController < ApplicationController
    before_action :set_trip, only: [:show, :update, :destroy]

    # GET /trips
    def index
      @trips = Trip.all

      render json: @trips
    end

    # GET /trips/1
    def show
      @companions = @trip.companions.map do |companion|
        companion.contact
      end
      puts @companions
      render json: {
        trip_time: @trip.trip_time,
        trip_owner: @trip.user.first_name,
        address: @trip.address,
        companions: @companions
      }
    end

    # POST /trips
    def create
      @trip = Trip.new(trip_params)

      if @trip.save
        render json: @trip, status: :created, location: api_v2_user_trips_url
      else
        render json: @trip.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /trips/1
    def update
      if @trip.update(trip_params)
        render json: @trip
      else
        render json: @trip.errors, status: :unprocessable_entity
      end
    end

    # DELETE /trips/1
    def destroy
      @trip.destroy
    end

    def created_mail
      @trip = Trip.find(params[:trip_id])
      @trip.contacts.each do |recipient|
        TripMailer.with(trip: @trip, contact: recipient).trip_email_start.deliver_now
      end
    end

    def completed_mail
      @trip = Trip.find(params[:trip_id])
      @trip.contacts.each do |recipient|
        TripMailer.with(trip: @trip, contact: recipient).trip_email_start.deliver_now
      end
    end

    def cancelled_mail
      @trip = Trip.find(params[:trip_id])
      @trip.contacts.each do |recipient|
        TripMailer.with(trip: @trip, contact: recipient).trip_email_start.deliver_now
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_trip
        @trip = Trip.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def trip_params
        params.require(:trip).permit(:user_id, :location_id, :trip_time, :address)
      end
    end
  end
end
