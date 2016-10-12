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

  describe '#check_conclusion_date_errors' do
    let(:project) { build(:project) }

    it 'has no additional error' do
      expect(project.errors).to be_empty
    end

    context 'given an invalid date entry' do
      let(:project) { build(:project, conclusion_date: 1) }

      it 'adds invalid conclusion date error' do
        expect(project.errors).to be_empty
      end
    end
  end

  describe '#mark_as_finished' do
    let(:project) { build(:project) }

    it 'updates state and conclusion date' do
      Timecop.freeze(Date.today) do
        project.mark_as_finished
        expect(project.reload.state).to eq(described_class::STATES.last)
        expect(project.reload.conclusion_date).to eq(Time.zone.now)
      end
    end
  end
end
