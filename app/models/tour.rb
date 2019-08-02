# == Schema Information
#
# Table name: tours
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  people     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tour < ApplicationRecord
  has_many :attraction_tours

  def self.pull_attractions(url)
    begin
      response = RestClient::Request.execute(
          :method => 'get',
          :url => url
      )
      return response
    rescue RestClient::ExceptionWithResponse => e
      return e.response
    end
  end

  private
    
    # Check with a given attraction date and hour has intersection in attraction into Tour
    def self.has_intersection?(date, hour, tour)
      current_date = Time.parse("#{date} #{hour}")
      has_intersection = false

      # if there isn't attraction in Tour on current date so there isn't intersection dates
      return has_intersection if !tour.attraction_tours.where('data = ?', date).exists?
      
      # if there is attractions in Tour goes through each one seeking for intersection hour and date
      tour.attraction_tours.each do |att|
        checkin = "#{att.data} #{att.checkin}".to_time
        checkout = Tour.format_checkout(att.data, att.checkin, att.attraction.duration)     
        if current_date.between?(checkin, checkout)
          has_intersection = true 
          break
        end
      end

      return has_intersection
    end

    # convert checkin hour to a checkout related to its duration
    def self.format_checkout(date, checkin, duration)
      Time.parse("#{date} #{checkin}") + duration * 60
    end

    def self.provide_checkout(attraction_id, date, hour)
      attraction = Attraction.find(attraction_id)
      
      checkout = Tour.format_checkout(date, hour, attraction.duration)
      "#{checkout.hour}:#{checkout.min}"
    end

end
