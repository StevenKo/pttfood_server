# encoding: utf-8
class CrawlWorker
  include Sidekiq::Worker
  
  def perform(articles_link)

    sleep(rand(100)/100.0)

    crawler = PttCrawler.new
    crawler.fetch articles_link
    crawler.crawl_articles
    sleep 0.4
  end
end