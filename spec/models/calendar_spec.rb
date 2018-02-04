require 'rails_helper'

RSpec.describe Calendar, type: :model do
  let(:user) { create(:user) }
  let(:calendar) { create(:calendar, user: user) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(3) }

  describe "attributes" do
    it "has title, description, and user attributes" do
      expect(calendar).to have_attributes(title: calendar.title, description: calendar.description, user: user)
    end
  end
end
