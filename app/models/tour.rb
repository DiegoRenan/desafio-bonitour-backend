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

end
