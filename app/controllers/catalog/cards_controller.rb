class Catalog::CardsController < ::ApplicationController
  def index
    @page = 0
    @next_page = 1
    @cards = Catalog::Card.order(swu_card_id: :desc).limit(21)
  end

  def more
    @page = params[:page].to_i
    @next_page = @page + 1
    @cards = Catalog::Card.order(swu_card_id: :desc).limit(21).offset(@page * 21)
  end
end
