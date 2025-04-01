class Catalog::Type < CatalogRecord
  has_many :card_fronts, class_name: "Catalog::Card", foreign_key: "front_type_id"
  has_many :card_backs, class_name: "Catalog::Card", foreign_key: "back_type_id"
end
