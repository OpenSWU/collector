class Catalog::Card < CatalogRecord
  belongs_to :expansion, class_name: "Catalog::Expansion"
  has_and_belongs_to_many :arenas, class_name: "Catalog::Arena", join_table: "cards_arenas"
  has_and_belongs_to_many :aspects, class_name: "Catalog::Aspect", join_table: "cards_aspects"
  has_and_belongs_to_many :keywords, class_name: "Catalog::Keyword", join_table: "cards_keywords"
  has_and_belongs_to_many :traits, class_name: "Catalog::Trait", join_table: "cards_traits"
end
