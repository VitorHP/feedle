class FetchEntriesService
  def fetch_entries(entries)
    entries.each do |entry|
      content = HTTParty.get(entry[:url])

      file = open("#{Rails.root}/public/entries/#{entry[:title].parameterize}.html", 'w')
      file.write(content)
      file.close
    end
  end
end
