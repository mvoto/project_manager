require 'rails_helper'

describe Note do
  context "Associations" do
    it { is_expected.to belong_to(:project) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:content) }
  end

  context "Callbacks" do
    before { subject.save }

    context 'given a content that should not update project state' do
      subject { build(:note) }

      it 'does not update project state' do
        expect(subject.project.reload.state).to eq("started")
      end
    end

    context 'given a content that is supposed to update project state' do
      subject { build(:note, content: 'mark as completing') }

      it 'updates project state as completing' do
        subject.save
        expect(subject.project.reload.state).to eq("completing")
      end
    end
  end
end
