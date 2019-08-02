class AttractionTourSerializer < ActiveModel::Serializer
  attributes :id, :data, :checkin, :checkout

  belongs_to :attraction
  belongs_to :tour
end
