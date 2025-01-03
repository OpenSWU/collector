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

  desc "Scrape Expansion data from Card List data"
  task expansions: :environment do
    json = File.read("tmp/storage/card_list.json")
    data = Oj.load(json)

    expansions = Set.new

    data.each do |card_data|
      expansions << card_data["attributes"]["expansion"]["data"]["attributes"]
    end

    expansions.each do |expansion_data|
      Expansion.create_with(title: expansion_data["name"]).find_or_create_by!(code: expansion_data["code"])
    end
  end

  desc "Scrape Aspects data from Card List data"
  task aspects: :environment do
    json = File.read("tmp/storage/card_list.json")
    data = Oj.load(json)

    aspects = Set.new

    data.each do |card_data|
      card_data["attributes"]["aspects"]["data"].each do |aspect_data|
        aspects << aspect_data["attributes"]
      end
    end

    aspects.each do |aspect_data|
      Aspect.create_with(description: aspect_data["description"], color: aspect_data["color"]).find_or_create_by!(name: aspect_data["name"])
    end
  end
end
