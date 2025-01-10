require 'rails_helper'

RSpec.describe CardData::Card, type: :model do
  its(:swuid) { is_expected.to be_nil }
  its(:swu_cardid) { is_expected.to be_nil }
  its(:title) { is_expected.to be_nil }
  its(:subtitle) { is_expected.to be_nil }
  its(:number) { is_expected.to be_nil }
  its(:set_code) { is_expected.to be_nil }
end
