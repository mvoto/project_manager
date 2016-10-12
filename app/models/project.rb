class Project < ApplicationRecord
  STATES = ["started", "approving", "building", "completing", "concluded"].freeze

  # Associations
  belongs_to :client
  has_many :notes

  # Validations
  validates :name, :client, :state, :conclusion_date, presence: true
  validates :state, inclusion: { in: STATES }

  def check_conclusion_date_errors(conclusion_date_entry)
    if conclusion_date_entry.present? && conclusion_date.nil?
      errors.add(:conclusion_date, 'is invalid')
    end
  end
end
