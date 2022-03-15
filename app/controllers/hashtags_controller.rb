class HashtagsController < ApplicationController
  def show
    @hashtag = params[:id]
    @results = Shout.
    joins("INNER JOIN text_shouts ON content_type = 'TextShout' AND content_id = text_shouts.id").
    where("body ILIKE ?", "%##{@hashtag}%")
  end
end