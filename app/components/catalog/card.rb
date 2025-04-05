class Components::Catalog::Card < Components::Base
  def initialize(card:)
    @card = card
  end

  def view_template
    if @card.front_art_is_horizontal?
      aspect_ratio =  "4/3"
      card_width = 82
    else
      aspect_ratio =  "3/4"
      card_width = 40
    end

    RubyUI::Card(class: "w-#{card_width} m-1 overflow-hidden") do
      RubyUI::AspectRatio(aspect_ratio: aspect_ratio, class: "border-b") do
        img(src: @card.front_art_url)
      end

      CardHeader do
        CardTitle { @card.title }
        CardDescription { @card.subtitle }
      end
    end
  end
end