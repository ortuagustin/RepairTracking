class Repair < ApplicationRecord
  has_many :revisions
  belongs_to :customer
  belongs_to :artifact

  after_create :generate_repair_code

  validates :estimated_days, numericality: { only_integer: true }

  def estimated_date
    self.created_at + self.estimated_days.days
  end

  def last_revision_date
    revision = self.revisions.order(created_at: :desc).first
    if revision.nil?
      Date.today
    else
      revision.created_at
    end
  end
private
  def generate_repair_code
    self.code = "#{customer.initials}#{id}"
    self.save!
  end
end
