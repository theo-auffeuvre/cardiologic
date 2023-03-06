class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.references :patient, null: false, foreign_key: true
      t.text :diagnostic

      t.timestamps
    end
  end
end
