require "rails_helper"

RSpec.describe Catalog::Trait do
  it { is_expected.to be_readonly }

  it { is_expected.to have_and_belong_to_many(:cards).class_name("Catalog::Card").join_table("cards_traits") }
end
