# encoding: utf-8
class CategoryWorker
  include Sidekiq::Worker
  
  def perform(category_id)
    c = Category.find(category_id)
    crawler = PttCrawler.new
    crawler.fetch c.link
    crawler.crawl_category_detail c.id
    sleep 0.4
  end
end