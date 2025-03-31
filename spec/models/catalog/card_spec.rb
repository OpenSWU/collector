require "rails_helper"

RSpec.describe Catalog::Card do
  it { is_expected.to be_readonly }

  it { is_expected.to belong_to(:expansion).class_name("Catalog::Expansion") }
  it { is_expected.to have_and_belong_to_many(:arenas).class_name("Catalog::Arena").join_table("cards_arenas") }
  it { is_expected.to have_and_belong_to_many(:aspects).class_name("Catalog::Aspect").join_table("cards_aspects") }
  it { is_expected.to have_and_belong_to_many(:keywords).class_name("Catalog::Keyword").join_table("cards_keywords") }
  it { is_expected.to have_and_belong_to_many(:traits).class_name("Catalog::Trait").join_table("cards_traits") }
end
