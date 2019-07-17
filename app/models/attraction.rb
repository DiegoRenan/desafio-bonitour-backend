# == Schema Information
#
# Table name: attractions
#
#  id         :integer          not null, primary key
#  code       :string
#  name       :string
#  duration   :integer
#  lat        :string
#  long       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attraction < ApplicationRecord
  has_many :attraction_tours
end
