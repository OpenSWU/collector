require "rails_helper"

RSpec.describe Catalog::Rarity do
  it { is_expected.to be_readonly }

  it { is_expected.to have_many(:cards).class_name("Catalog::Card").with_foreign_key("rarity_id") }
end