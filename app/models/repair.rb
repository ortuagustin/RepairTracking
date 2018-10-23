class Repair < ApplicationRecord
  belongs_to :customer
  belongs_to :artifact
end
