class Catalog::Card < CatalogRecord
  has_and_belongs_to_many :arenas, class_name: "Catalog::Arena", join_table: "cards_arenas"
  has_and_belongs_to_many :aspects, class_name: "Catalog::Aspect", join_table: "cards_aspects"
end
