require 'rails_helper'

RSpec.describe Expansion, type: :model do
  its(:code) { is_expected.to be_nil }
  its(:title) { is_expected.to be_nil }
  its(:released_on) { is_expected.to be_nil }
  its(:sort_order) { is_expected.to be_nil }
end
