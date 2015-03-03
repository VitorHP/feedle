require 'pathname'

class ConvertService
  def convert(files)
    files.each do |file|
      system "ebook-convert #{file} #{"#{Rails.root}/public/ebooks/#{File.basename(file, '.*')}.mobi"}"
    end
  end
end
