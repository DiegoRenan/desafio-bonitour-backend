module V1
  class AttractionSerializer < ActiveModel::Serializer
    attributes :id, :name, :duration, :lat, :long
  
    has_many :attraction_tours
  
  end    
end
