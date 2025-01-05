module CardSearching
  extend ActiveSupport::Concern

  included do
    has_one :card_search, foreign_key: "rowid"
  end

  def populate_card_search
    return if card_search

    sql = ActiveRecord::Base.sanitize_sql_array(
      [
        "INSERT INTO card_search (rowid, title, subtitle, set_code) VALUES (?, ?, ?, ?)",
        id, title, subtitle, set_code
      ]
    )
    ActiveRecord::Base.connection.execute(sql)
  end

  class_methods do
    def full_text_search(input:, limit:)
      where("card_search MATCH ?", input)
        .joins(:card_search)
        .limit(limit)
        .order("bm25(card_search)")
        .distinct
    end
  end
end
