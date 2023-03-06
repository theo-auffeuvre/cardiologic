class Consultation < ApplicationRecord
  belongs_to :patient
  belongs_to :general_practitioner_user, class_name: "User", foreign_key: "user_id"
  belongs_to :cardiologist_user, class_name: "User", foreign_key: "user_id"
  accepts_nested_attributes_for :patient
end
