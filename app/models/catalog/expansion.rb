class Catalog::Expansion < CatalogRecord
  has_many :cards, class_name: "Catalog::Card", foreign_key: "expansion_id"
end