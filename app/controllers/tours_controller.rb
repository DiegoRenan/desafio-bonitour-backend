class ToursController < ApplicationController
  before_action :set_tour, only: [:show, :update, :destroy]

  def create_tour
    @tour = Tour.new(tour_params)
    
    render json: @tour.errors, status: :unprocessable_entity unless @tour.save

    base_url = "https://bonitour-test-api.herokuapp.com/attractions"
    
    attraction_tours = @tour.attraction_tours.all 

    # Array to keep the attractions from heroku endpoint
    attractions_server = Array.new

    # get all attractions between start_date and end_date. 
    # Then, add each attraction to attractions_server array
    Attraction.all.each do |attraction|
      response = Tour.pull_attractions(base_url+"/#{attraction.code}?start_date=#{@tour.start_date}&end_date=#{@tour.end_date}")
      attractions_server.push(JSON.parse(response.body)) if response.code == 200
    end
    
    
    if @tour.save
      
      # save attractions into Tour
      sort_attractions(attractions_server, @tour)

      render json: @tour, include: [:attraction_tours], status: :created 
    else
      render json: @tour.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @tour, include: [:attraction_tours]
  end

  private

    def tour_params
      params.require(:tour).permit(:start_date, :end_date, :people)
    end

    def set_tour
      @tour = Tour.find(params[:id])
    end
    
    def sort_attractions(attractions_server, tour)
      # start to search by first hour
      horario = 0
      current_date = tour.start_date.strftime("%Y-%m-%d")
      hour = nil
      index = 0

      #goes through each attraction in attractions get from heroku searching looking for a hour
      until index == attractions_server.length
        # get a hour starting for the first hour in the first attraction with same current date
        hour = get_attraction_hour(attractions_server[index], current_date, horario)

        if hour === -1
          # search for another attraction if current attractions has no more hour available
          index += 1
        elsif hour.nil?
          # search for another date with there is no more hour available for this attracion date
          current_date = (Date.parse(current_date) + 1.day).strftime("%Y-%m-%d")
          horario = 0
          index += 1
        elsif has_intersection?(current_date, hour, tour)
          # if this hour has intersection in tour look for the next period of the time
          horario += 1
        else
          # save attraction in the Tour and look for the next period of the time
          save_attraction(tour, attractions_server[index], current_date, hour)
          horario += 1
        end
      end
    end


    def get_attraction_hour(attraction, date, horario)
      index_date = 0
      
      #looking for the index of the date passed by parameter
      loop do
        #stopping search if it went through all hour available or it finds that date
        break if (index_date == attraction["availability"].length) || !attraction["availability"][index_date][date].nil?
        index_date += 1
      end
      
      if index_date == attraction["availability"].length
        #there isn't the current date in this attractions
        return -1         
      elsif horario == attraction["availability"][index_date][date].length
        #there isn't more hour available in this date
        return nil
      else
        #there is a hour in this date
        return attraction["availability"][index_date][date][horario].keys[0]
      end

    end

    def save_attraction(tour, attraction, current_date, hour)
      id = Attraction.where('code = ?', attraction["id"]).take.id
      attraction = Attraction.find(id)
      
      checkout = format_checkout(current_date, hour, attraction.duration)
      checkout = "#{checkout.hour}:#{checkout.min}"

      ActiveRecord::Base.transaction do
        tour.attraction_tours.create!(
          data: current_date,
          checkin: hour,
          checkout: checkout,
          attraction_id: id)
      end
    end

    def has_intersection?(date, hour, tour)
      current_date = Time.parse("#{date} #{hour}")
      has_intersection = false

      return has_intersection if !tour.attraction_tours.where('data = ?', date).exists?
      
      tour.attraction_tours.each do |att|
        checkin = "#{att.data} #{att.checkin}".to_time
        checkout = format_checkout(att.data, att.checkin, att.attraction.duration)     
        if current_date.between?(checkin, checkout)
          has_intersection = true 
          break
        end
      end

      return has_intersection
    end

    def format_checkout(date, checkin, duration)
      Time.parse("#{date} #{checkin}") + duration * 60
    end
end

