class AttractionToursController < ApplicationController
  before_action :set_tour

  # GET /tours/1/attractions
  def show
    render json: @tour.attraction_tours, include: [:attraction]
  end

  # POST /tours/1/attraction
  def create
  end

  # DELETE /tours/1/attractions/1
  def destroy
   @attraction_tour = @tour.attraction_tours.find(params[:id])
   @attraction_tour.destroy
  end

  private
    def set_tour
      @tour = Tour.find(params[:tour_id])
    end

end
