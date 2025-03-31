class Catalog::Arena < CatalogRecord
  has_and_belongs_to_many :cards, class_name: "Catalog::Card", join_table: "cards_arenas"
end
