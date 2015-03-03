namespace :ebooks do
  desc 'process unread articles converting and sending them to the kindle service'
  task process: :environment do
    fs  = FeedlyService.new
    fes = FetchEntriesService.new
    cs  = ConvertService.new

    fes.fetch_entries(fs.unread_entries_urls)

    cs.convert(Dir['public/entries/*.html'])

    EbookMailer.ebooks_mail.deliver_now
  end
end
