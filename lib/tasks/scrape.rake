require "faraday"
require "oj"
require "progress_bar"

namespace :scrape do
  desc "Scrape Card List API endpoint for English cards"
  task card_list: :environment do
    FileUtils.mkdir_p("tmp/storage/card_list")
    @connection = ::Faraday.new(headers: { "Content-Type": "application/json" })

    def fetch_page(page = 1)
      @connection.get "https://admin.starwarsunlimited.com/api/card-list", {
        locale: "en",
        "filters[variantOf][id][$null]": true,
        "pagination[pageSize]": 50,
        "pagination[page]": page
      }
    end

    def remaining_pages_from(results)
      results["meta"]["pagination"]["pageCount"].to_i - 1
    end

    results = fetch_page(1)
    File.write("tmp/storage/card_list/1.json", results.body)

    pages = remaining_pages_from(Oj.load(results.body))
    progress = ProgressBar.new(pages)

    pages.times do |increment|
      page = increment + 2
      results = fetch_page(page)
      File.write("tmp/storage/card_list/#{page}.json", results.body)
      progress.increment!
    end

    card_list = []

    Rake::FileList["tmp/storage/card_list/*.json"].each do |file|
      json = File.read(file)
      data = Oj.load(json)["data"]
      card_list.concat(data)
    end

    File.write("tmp/storage/card_list.json", Oj.dump(card_list))
  end

  desc "Load Expansion data from Card List data"
  task expansions: :environment do
    json = File.read("tmp/storage/card_list.json")
    data = Oj.load(json)

    expansions = Set.new

    data.each do |card_data|
      expansion_data = card_data["attributes"]["expansion"]["data"]["attributes"]

      expansions << {
        code: expansion_data["code"],
        title: expansion_data["name"],
        sort_order: expansion_data["sortValue"]
      }
    end

    Expansion.upsert_all(expansions.to_a, unique_by: :code)
  end

  desc "Load Aspects data from Card List data"
  task aspects: :environment do
    json = File.read("tmp/storage/card_list.json")
    data = Oj.load(json)

    aspects = Set.new

    data.each do |card_data|
      card_data["attributes"]["aspects"]["data"].each do |aspect_data|
        aspects << {
          name: aspect_data["attributes"]["name"],
          description: aspect_data["attributes"]["description"],
          color: aspect_data["attributes"]["color"],
          sort_order: aspect_data["attributes"]["sortValue"]
        }
      end
    end

    Aspect.upsert_all(aspects.to_a, unique_by: :name)
  end

  desc "Load Card data from Card List data"
  task cards: :environment do
    json = File.read("tmp/storage/card_list.json")
    data = Oj.load(json)

    cards = Set.new

    data.each do |card_data|
      cards << {
        swuid: card_data["id"],
        swu_cardid: card_data["attributes"]["cardUid"],
        title: card_data["attributes"]["title"],
        subtitle: card_data["attributes"]["subtitle"],
        number: card_data["attributes"]["cardNumber"],
        set_code: card_data["attributes"]["expansion"]["data"]["attributes"]["code"]
      }
    end

    Card.upsert_all(cards.to_a, unique_by: %i[swuid swu_cardid])
  end
end
