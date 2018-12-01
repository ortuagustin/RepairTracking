class Task < ApplicationRecord
  belongs_to :artifact

  validates :name, :description, :cost, presence: true
  validates :cost, numericality: true
end
