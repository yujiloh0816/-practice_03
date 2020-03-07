class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Validates
  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 20 },
            uniqueness: true

  validates :email,
            presence: true,
            uniqueness: true

end
