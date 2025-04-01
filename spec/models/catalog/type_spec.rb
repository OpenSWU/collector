require "rails_helper"

RSpec.describe Catalog::Type do
  it { is_expected.to be_readonly }

  it { is_expected.to have_many(:card_fronts).class_name("Catalog::Card").with_foreign_key("front_type_id") }
  it { is_expected.to have_many(:card_backs).class_name("Catalog::Card").with_foreign_key("back_type_id") }
end
