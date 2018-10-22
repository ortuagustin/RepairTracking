class Customer < ApplicationRecord
  validates :name, :surname, :email, :phone, presence: true
  validates :name, :surname, :email, length: { maximum: 30 }
  validates :phone, format: { with: /(\d{3}-)?\d{3}-\d{4}/, message: :invalid_phone }
  validates :email, email: { message: :invalid_email }
end
