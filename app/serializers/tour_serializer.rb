class TourSerializer < ActiveModel::Serializer
  # É recomendável seguir o padrão ISO 8601 para datas
  # Seguindo o padrão adotado pela expecificação do desafio
  attributes :id, :start_date, :end_date

  has_many :attraction_tours
end
