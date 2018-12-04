class Task < ApplicationRecord
  belongs_to :artifact

  validates :name, :cost, presence: true
  validates :cost, numericality: true
end
