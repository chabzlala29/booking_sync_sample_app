module ApplicationHelper
  def published_since(datetime)
    "published #{time_ago_in_words(datetime)} ago" if datetime
  end
end
