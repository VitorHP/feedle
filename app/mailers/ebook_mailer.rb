class EbookMailer < ApplicationMailer

  def ebooks_mail
    @ebooks = Dir['public/ebooks/*.mobi']

    m = mail(to: 'vitohp2@kindle.com', subject: 'Send to Kindle')

    @ebooks.each do |ebook|
      m.attachments[File.basename(ebook)] = File.read(ebook)
    end

    m
  end
end
