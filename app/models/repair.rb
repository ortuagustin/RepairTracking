class Repair < ApplicationRecord
  has_many :revisions, dependent: :delete_all
  belongs_to :customer
  belongs_to :artifact

  after_create :generate_repair_code
  before_save :set_pending_state

  validates :estimated_days, numericality: { only_integer: true }

  def estimated_date
    self.created_at + self.estimated_days.days
  end

  def last_revision_date
    return self.created_at if self.revisions.empty?

    self.revisions.order(created_at: :desc).first.created_at
  end

  def state=(value)
    super(value.upcase)
  end

  def state
    super.upcase
  end
private
  def set_pending_state
    self.state ||= 'PENDIENTE'
  end

  def generate_repair_code
    self.code = "#{customer.initials}#{id}"
    self.save!
  end
end
