class CreateEcgs < ActiveRecord::Migration[7.0]
  def change
    create_table :ecgs do |t|
      t.text :data
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
