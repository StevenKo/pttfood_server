# encoding: utf-8
class DetailWorker
  include Sidekiq::Worker
  
  def perform(article_id)
    article = Article.find(article_id)
    crawler = PttCrawler.new
    crawler.fetch article.ptt_web_link
    crawler.crawl_article_detail article.id
    sleep 0.4
  end
end