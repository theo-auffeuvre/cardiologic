class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :patients
  has_many :general_practitioner_user, class_name: "Consultation", foreign_key: "general_practitioner_user_id"
  has_many :cardiologist_user, class_name: "User", foreign_key: "cardiologist_user_id"
  has_many :messages
  enum :speciality, %i[cardiologist general_practitioner]
end
