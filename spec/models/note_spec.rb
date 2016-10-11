require 'rails_helper'

describe Note do
  context "Associations" do
    it { is_expected.to belong_to(:project) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:content) }
  end
end
