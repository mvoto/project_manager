require 'rails_helper'

describe Project do
  context "Associations" do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to have_many(:notes) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:conclusion_date) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:client) }

    it { is_expected.to validate_inclusion_of(:state).in_array described_class::STATES }
  end
end
