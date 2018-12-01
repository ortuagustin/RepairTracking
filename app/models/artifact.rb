class Artifact < ApplicationRecord
  has_many :repairs, dependent: :delete_all
  has_many :pieces, dependent: :delete_all
  has_many :tasks, dependent: :delete_all

  validates :name, :model, presence: true
  validates :model, uniqueness: true
end
