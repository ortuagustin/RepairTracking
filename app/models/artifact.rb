class Artifact < ApplicationRecord
  has_many :repairs, dependent: :delete_all
  validates :name, :model, presence: true
  validates :model, uniqueness: true
end
