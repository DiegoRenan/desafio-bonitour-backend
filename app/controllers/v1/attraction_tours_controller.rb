module V1
  class AttractionToursController < ApplicationController
    include ErrorSerializer

    before_action :set_tour

    # GET /tours/1/attractions
    def show
      render json: @tour.attraction_tours, include: [:attraction]
    end

    # POST /tours/1/attraction
    def create
      if Tour.has_intersection?(attraction_params[:data], attraction_params[:checkin], @tour)
        @tour.errors.add(:"choque de horarios", "O passeio não foi adicionado por não possuir disponiblidade dentro do período informado")
        render json: ErrorSerializer.serialize(@tour.errors), status: :unprocessable_entity
      else
        checkout = Tour.provide_checkout( attraction_params[:attraction_id],
                                          attraction_params[:data], 
                                          attraction_params[:checkin], )

        @tour.attraction_tours << AttractionTour.new( :data => attraction_params[:data], 
                                                      :checkin => attraction_params[:checkin],
                                                      :checkout => checkout,
                                                      :attraction_id => attraction_params[:attraction_id]
                                                      )

        if @tour.save
          render json: @tour.attraction_tours, status: :created
        else
          render json: ErrorSerializer.serialize(@tour.errors), status: :unprocessable_entity
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
        ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:data, :checkin, :attraction_id])
      end
  end
end