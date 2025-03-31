class Catalog::Keyword < CatalogRecord
  has_and_belongs_to_many :cards, class_name: "Catalog::Card", join_table: "cards_keywords"
end