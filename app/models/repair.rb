class Repair < ApplicationRecord
  belongs_to :customer
  belongs_to :artifact

  after_create :generate_repair_code

  validates :estimated_days, numericality: { only_integer: true }
private
  def generate_repair_code
    self.code = "#{customer.initials}#{id}"
    self.save!
  end
end
