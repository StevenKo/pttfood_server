# encoding: utf-8
class PttCrawler
  include Crawler

  def crawl_articles
    nodes = @page_html.css("#prodlist dl dd")
    nodes.each do |node|
      article = Article.new
      article.title = node.css("a")[0].text.strip
      next if article.title == ""
      next if not_include_title(article.title)
      article.ptt_web_link = "http://www.ptt.cc" + node.css("a")[0][:href]
      next if Article.find_by_ptt_web_link(article.ptt_web_link)
      article.author = node.xpath("//td[@width='120']")[0].text
      puts article.title
      article.save
    end
  end

  def not_include_title title
    return true if title.index("本文已被刪除")
    return true if title.index("公告")
    return false
  end

  def crawl_article_detail article_id
    article = Article.find(article_id)
    
    begin
      nodes = @page_html.css("#mainContent")
      content = nodes.children[3].text
    rescue
      nodes = @page_html.css("#mainContainer .bbsContent")
      content = nodes.text
    end

    if content.match("http.*blog.*\.html")
        link = content.match("http.*blog.*\.html")[0]
        article.link = link
    end

    if content.index("作者:")
      texts =content.split("\n")
      release_time = texts[2][4..texts[2].size]
      content = texts[4..texts.size].join("\n")
      texts[0].match("作者: (.*) 看板")
      article.author = $1
      article.release_time = release_time
      article.content = content
    else
      article.content = content
    end
    
    article.is_show = true
    article.save
    puts article.title
  end

  def crawl_areas
    nodes = @page_html.css("#prodlist a")
    nodes.each do |node|
      c = Category.new
      c.name = node.text
      c.link = "http://www.ptt.cc" + node[:href]
      next if Category.find_by_link(c.link)
      c.is_area = true
      c.save
    end
  end

  def crawl_categries
    nodes = @page_html.css("#prodlist a")
    nodes.each do |node|
      c = Category.new
      c.name = node.text
      c.link = "http://www.ptt.cc" + node[:href]
      next if Category.find_by_link(c.link)
      c.parent_id = 0
      c.save
    end
  end

  def crawl_category_detail parent_category_id
    nodes = @page_html.css("#prodlist dd")
    nodes.each do |node|
      img_src = node.css("img")[0][:src]
      a_node = node.css("a")[0]
      if img_src.index("folder")
        # next if Category.find_by_link("http://www.ptt.cc" + a_node[:href])
        next if a_node.text.index("◎----")
        next if a_node.text.index("=======")
        
        if c1 = Category.find_by_link("http://www.ptt.cc" + a_node[:href])
          CategoryWorker.perform_async(c1.id)
          next
        end

        c = Category.new
        c.name = a_node.text
        c.link = "http://www.ptt.cc" + a_node[:href]
        c.parent_id = parent_category_id
        c.save
        CategoryWorker.perform_async(c.id)
      else
        next if Article.find_by_ptt_web_link("http://www.ptt.cc" + a_node[:href])
        article = Article.new
        article.title = a_node.text
        article.ptt_web_link = "http://www.ptt.cc" + a_node[:href]
        article.category_id = parent_category_id
        article.is_from_category = true
        article.save
      end
    end
  end 
end
