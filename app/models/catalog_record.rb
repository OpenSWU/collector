class CatalogRecord < ActiveRecord::Base
  primary_abstract_class

  connects_to database: { writing: :catalog, reading: :catalog }

  def readonly?
    true
  end
end
