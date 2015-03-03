class FeedlyService
  def subscriptions_by_category
    client.user_subscriptions.each_with_object({}) do |subscription, memo|
      subscription['categories'].each do |category|
        memo[category['label']] ||= []
        memo[category['label']] << subscription
      end
    end
  end

  def unread_selected_entries
    Feed.all.pluck(:feed_id).each_with_object([]) do |feed_id, memo|
      memo << client.stream_entries_ids(feed_id, unreadOnly: true).ids
    end.flatten
  end

  def unread_entries_urls
    client.user_entries(unread_selected_entries).map do |entry|
      { title: entry['title'], url: entry['originId'] }
    end
  end

  private

  def client
    @client ||= Feedlr::Client.new(oauth_access_token: 'AnNRppd7ImEiOiJGZWVkbHkgRGV2ZWxvcGVyIiwiZSI6MTQzMjE1ODgzOTgwNSwiaSI6Ijg3NmJjYjE1LWY0NzUtNDk2NS04MmM3LTVhMzI5NjU1OThiMSIsInAiOjYsInQiOjEsInYiOiJwcm9kdWN0aW9uIiwidyI6IjIwMTMuMTEiLCJ4Ijoic3RhbmRhcmQifQ:feedlydev')
  end
end
