module ApplicationHelper
  def published_since(datetime)
    if datetime && datetime.is_a?(DateTime)
      "published #{time_ago_in_words(datetime)} ago"
    end
  end
end
