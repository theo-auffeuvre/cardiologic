class AddReferencesToConsultations < ActiveRecord::Migration[7.0]
  def change
    change_table(:consultations) do |t|
      t.references :general_practitioner_user, foreign_key: { to_table: "users" }
      t.references :cardiologist_user, foreign_key: { to_table: "users" }
    end
  end
end
