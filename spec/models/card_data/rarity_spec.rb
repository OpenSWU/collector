require 'rails_helper'

RSpec.describe CardData::Rarity, type: :model do
  its(:name) { is_expected.to be_nil }
  its(:character) { is_expected.to be_nil }
  its(:color) { is_expected.to be_nil }
  its(:sort_order) { is_expected.to be_nil }
end
