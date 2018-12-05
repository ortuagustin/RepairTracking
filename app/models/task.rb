class Task < ApplicationRecord
  include Searchable

  belongs_to :artifact

  validates :name, :cost, presence: true
  validates :cost, numericality: true

  def self.searchable_fields
    %w[name cost]
  end
end
