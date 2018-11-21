class Piece < ApplicationRecord
  belongs_to :artifact

  validates :name, uniqueness: { scope: :artifact }
  validates :name, presence: true
end
