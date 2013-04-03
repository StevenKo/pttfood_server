# encoding: utf-8
class CategoryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "ptt"
  
  def perform(category_id)

    sleep(rand(50)/10.0)
    
    c = Category.find(category_id)
    crawler = PttCrawler.new
    crawler.fetch c.link
    crawler.crawl_category_detail c.id
    
  end
end