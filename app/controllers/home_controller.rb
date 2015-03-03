class HomeController < ApplicationController
  def index
    @feedly = FeedlyService.new

    @chosen_feeds = Feed.all.pluck(:feed_id)
  end

  def submit
    Feed.destroy_all

    params['feed_ids'].to_a.each do |feed_id|
      Feed.create feed_id: feed_id
    end

    redirect_to home_index_path
  end
end
