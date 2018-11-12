class Artifact < ApplicationRecord
  validates :name, :model, presence: true
  validates :model, uniqueness: true
end
