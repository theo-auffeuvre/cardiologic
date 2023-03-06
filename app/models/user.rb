class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :patients
  has_many :consultations
  has_many :messages
  enum :speciality, %i[cardiologist general_practitioner]
end
