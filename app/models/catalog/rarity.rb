class Catalog::Rarity < CatalogRecord
  has_many :cards, class_name: "Catalog::Card", foreign_key: "rarity_id"
end