require 'rails_helper'

RSpec.describe Arena, type: :model do
  its(:name) { is_expected.to be_nil }
  its(:description) { is_expected.to be_nil }
end