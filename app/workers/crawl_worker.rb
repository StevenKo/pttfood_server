# encoding: utf-8
class CrawlWorker
  include Sidekiq::Worker
  
  def perform(articles_link)

    sleep(rand(50)/10.0)

    crawler = PttCrawler.new
    crawler.fetch articles_link
    crawler.crawl_articles
    
  end
end