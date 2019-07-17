class ToursController < ApplicationController
  
  def create_tour
  
  end

  private

    def tour_params
      params.require(:tour).permit(:start_date, :end_date, :people)
    end

end
