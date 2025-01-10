class CardDataRecord < ApplicationRecord
  self.abstract_class = true

  connects_to database: { writing: :card_data }
end
