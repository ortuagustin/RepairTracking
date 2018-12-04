class Piece < ApplicationRecord
  belongs_to :artifact

  validates :name, uniqueness: { scope: :artifact }
  validates :name, :cost, presence: true
  validates :cost, numericality: true
end
