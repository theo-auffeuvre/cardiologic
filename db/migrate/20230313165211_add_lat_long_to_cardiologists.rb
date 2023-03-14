class AddLatLongToCardiologists < ActiveRecord::Migration[7.0]
  def change
    add_column :cardiologists, :lat, :float
    add_column :cardiologists, :lgn, :float
  end
end
