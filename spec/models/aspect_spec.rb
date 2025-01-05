require 'rails_helper'

RSpec.describe Aspect, type: :model do
  its(:name) { is_expected.to be_nil }
  its(:description) { is_expected.to be_nil }
  its(:color) { is_expected.to be_nil }
end
