module ShoutHelper
  def like_button(shout)
    if current_user.liked?(shout)
      link_to "unlike", unlike_shout_path(shout), method: :delete, class: "like-padding-left"
    else
      link_to "like", like_shout_path(shout), method: :post, class: "like-padding-left"
    end
  end

  def auto_link(text)
    text.
    gsub(/@\w+/) { |mention| link_to mention, user_path(mention[1..-1])}.
    gsub(/#\w+/) { |hashtag| link_to hashtag, hashtag_path(hashtag[1..-1])}.
    html_safe
  end

  def shout_form_for(content_type)
    form_for(Shout.new, url: content_type.new) do |f|
      f.fields_for(:content) { |c| yield c } +
      f.submit("Post shout")
    end
  end
end

