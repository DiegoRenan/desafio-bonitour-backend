# == Schema Information
#
# Table name: attraction_tours
#
#  id            :integer          not null, primary key
#  data          :date
#  checkin       :string
#  checkout      :string
#  attraction_id :integer
#  tour_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class AttractionTour < ApplicationRecord
  belongs_to :attraction
  belongs_to :tour
end
