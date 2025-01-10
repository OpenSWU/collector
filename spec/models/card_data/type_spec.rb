require 'rails_helper'

RSpec.describe CardData::Type, type: :model do
  its(:name) { is_expected.to be_nil }
  its(:description) { is_expected.to be_nil }
  its(:sort_order) { is_expected.to be_nil }
end
