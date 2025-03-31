require "rails_helper"

RSpec.describe Catalog::Card do
  it { is_expected.to be_readonly }

  it { is_expected.to have_and_belong_to_many(:arenas).class_name("Catalog::Arena").join_table("cards_arenas") }
  it { is_expected.to have_and_belong_to_many(:aspects).class_name("Catalog::Aspect").join_table("cards_aspects") }
end
