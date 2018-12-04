class Customer < ApplicationRecord
  has_many :repairs, dependent: :delete_all

  validates :name, :surname, :email, :phone, presence: true
  validates :name, :surname, :email, length: { maximum: 50 }
  validates :phone, format: { with: /(\d{3}-)?\d{3}-\d{4}/, message: :invalid_phone }

  def initials
    name_initials = name.split(' ').collect { |s| s[0] }.join('')
    surname_initials = surname.split(' ').collect { |s| s[0] }.join('')
    name_initials + surname_initials
  end
end
