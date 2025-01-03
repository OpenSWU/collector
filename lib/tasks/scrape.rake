require "faraday"
require "oj"
require "progress_bar"

namespace :scrape do
  desc "Scrape Card List API endpoint for English cards"
  task cards: :environment do
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
end
