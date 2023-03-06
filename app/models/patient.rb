class Patient < ApplicationRecord
  has_many :consultations, inverse_of: :patient
  has_many :ecgs

end
