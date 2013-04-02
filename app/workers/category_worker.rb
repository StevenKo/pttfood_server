# encoding: utf-8
class CategoryWorker
  include Sidekiq::Worker
  
  def perform(category_id)

    sleep(rand(50)/10)
    
    c = Category.find(category_id)
    crawler = PttCrawler.new
    crawler.fetch c.link
    crawler.crawl_category_detail c.id
    
  end
end