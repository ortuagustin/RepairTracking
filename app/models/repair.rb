class Repair < ApplicationRecord
  belongs_to :customer
  belongs_to :artifact

  validates :estimated_days, numericality: { only_integer: true }
end
