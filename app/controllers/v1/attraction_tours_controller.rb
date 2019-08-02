module V1
  class AttractionToursController < ApplicationController
    before_action :set_tour

    # GET /tours/1/attractions
    def show
      render json: @tour.attraction_tours, include: [:attraction]
    end

    # POST /tours/1/attraction
    def create
      puts "checkin"
      puts attraction_params[:data]
      if Tour.has_intersection?(attraction_params[:data], attraction_params[:checkin], @tour)
        render json: @tour.errors, status: :unprocessable_entity
      else
        @tour.attraction_tours << AttractionTour.new(attraction_params)

        if @tour.save
          render json: @tour.attraction_tours, status: :created
        else
          render json: @tour.errors, status: :unprocessable_entity
        end
      end

    end

    # DELETE /tours/1/attraction/1
    def destroy
    @attraction_tour = @tour.attraction_tours.find(params[:id])
    @attraction_tour.destroy
    end

    private
      
      def set_tour
        @tour = Tour.find(params[:tour_id])
      end

      def attraction_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:data, :checkin, :checkout, :attraction_id])
      end
  end
end