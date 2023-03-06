class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :birth_date
      t.integer :height
      t.integer :weight

      t.timestamps
    end
  end
end
