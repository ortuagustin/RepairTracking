class Piece < ApplicationRecord
  include Searchable

  belongs_to :artifact

  validates :name, uniqueness: { scope: :artifact }
  validates :name, :cost, presence: true
  validates :cost, numericality: true

  def self.searchable_fields
    %w[name]
  end
end
