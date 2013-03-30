# encoding: utf-8
class CrawlWorker
  include Sidekiq::Worker
  
  def perform(articles_link)
    crawler = PttCrawler.new
    crawler.fetch "http://www.ptt.cc/bbs/Food/index#{i}.html"
    crawler.crawl_articles
    sleep 0.4
  end
end