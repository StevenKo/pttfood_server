env :PATH, ENV['PATH']


every :day, :at => '10:13am,03:00pm' do
  rake 'crawl:crawl_ptt_new_articles',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end