class Book < ApplicationRecord

  # Associations
  belongs_to :user

  # Validates
  validates :title,
            presence: true
  validates :body,
            presence: true,
            length: { maximum: 200 }

end
