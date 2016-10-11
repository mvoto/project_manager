require 'rails_helper'

describe Client do
  context "Associations" do
    it { is_expected.to have_many(:projects) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
