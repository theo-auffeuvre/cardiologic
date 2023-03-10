desc 'Importing cardiologists in db'
task import_db_cardiologists: [:environment] do
  require 'csv'
  # unless Cardiologist.exists?
    items = []
    CSV.foreach('./lib/assets/cardiologists.csv', headers: true, encoding: "bom|utf-8") do |row|
      Cardiologist.create!(row.to_hash)
    end
  # end
end