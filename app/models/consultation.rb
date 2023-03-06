class Consultation < ApplicationRecord
  belongs_to :patient
  belongs_to :general_practitioner_user, class_name: "User"
  belongs_to :cardiologist_user, class_name: "User", optional: true
  accepts_nested_attributes_for :patient
end
