# encoding: utf-8
namespace :crawl do

  task :crawl_ptt_new_articles => :environment do
    crawler = PttCrawler.new
    crawler.fetch "http://www.ptt.cc/bbs/Food/index.html"
    page = crawler.page_html.css("#prodlist h2")
    page_name = page.text.match(/\d+/)[0].to_i
    (page_name-20..page_name).each do |i|
      CrawlWorker.perform_async("http://www.ptt.cc/bbs/Food/index#{i}.html")
    end
  end

  task :crawl_ptt_whole_article => :environment do
    crawler = PttCrawler.new
    crawler.fetch "http://www.ptt.cc/bbs/Food/index.html"
    page = crawler.page_html.css("#prodlist h2")
    page_name = page.text.match(/\d+/)[0].to_i
    (1..page_name).each do |i|
      CrawlWorker.perform_async("http://www.ptt.cc/bbs/Food/index#{i}.html")
    end
  end

  task :crawl_article_detail => :environment do
    Article.where("content is null").select("id,ptt_web_link").find_in_batches do |articles|
      articles.each do |article|
        DetailWorker.perform_async(article.id)
      end
    end
  end

  task :crawl_areas => :environment do
    crawler = PttCrawler.new
    crawler.fetch "http://www.ptt.cc/man/Food/D9DA/index.html"
    crawler.crawl_areas
  end

  task :crawl_categories => :environment do
    crawler = PttCrawler.new
    crawler.fetch "http://www.ptt.cc/man/Food/DB9A/index.html"
    crawler.crawl_categries
  end

  task :crawl_category_detail => :environment do
    Category.where("parent_id = 0 or is_area = true").each do |c|
      CategoryWorker.perform_async(c.id)
    end
  end

  task :recrawl_article_detail => :environment do
     Article.where("is_from_category = false").find_in_batches do |articles|
      articles.each do |article|
        DetailWorker.perform_async(article.id)
      end
     end
  end
end