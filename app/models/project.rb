class Project < ApplicationRecord
  STATES = ["started", "approving", "building", "completing", "concluded"]

  # Associations
  belongs_to :client

  # Validations
  validates :name, :client, :state, :conclusion_date, presence: true
  validates :state, inclusion: { in: STATES }
end
