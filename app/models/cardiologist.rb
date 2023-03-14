class Cardiologist < ApplicationRecord
  extend Geocoder::Model::ActiveRecord
  geocoded_by :address, latitude: :lat, longitude: :lgn
end
