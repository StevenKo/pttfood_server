# encoding: utf-8
class DetailWorker
  include Sidekiq::Worker
  sidekiq_options queue: "ptt"
  
  def perform(article_id)

    sleep(rand(50)/10.0)

    article = Article.find(article_id)
    crawler = PttCrawler.new
    crawler.fetch article.ptt_web_link
    crawler.crawl_article_detail article.id

  end
end