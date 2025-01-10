require 'rails_helper'

RSpec.describe CardData::Aspect, type: :model do
  its(:name) { is_expected.to be_nil }
  its(:description) { is_expected.to be_nil }
  its(:color) { is_expected.to be_nil }
  its(:sort_order) { is_expected.to be_nil }
end
