desc 'Geocode in db'
task geocode_db_cardiologists: [:environment] do
  require 'mapbox'
  Mapbox.access_token = ENV['MAPBOX_API_KEY']
    Cardiologist.all.each do |cardiologist|
       h = Mapbox::Geocoder.geocode_forward("#{cardiologist['Numéro Voie']} #{cardiologist['Libellé Voie']} #{cardiologist['Code Postal']}")
       coordinates =  h[0]["features"][0]["geometry"]["coordinates"]
       cardiologist.lat = coordinates[1]
       cardiologist.lgn = coordinates[0]
       cardiologist.save
    end
end