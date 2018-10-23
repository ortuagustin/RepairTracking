class Customer < ApplicationRecord
  has_many :repairs

  validates :name, :surname, :email, :phone, presence: true
  validates :name, :surname, :email, length: { maximum: 50 }
  validates :phone, format: { with: /(\d{3}-)?\d{3}-\d{4}/, message: :invalid_phone }
  validates :email, email: { message: :invalid_email }
end
