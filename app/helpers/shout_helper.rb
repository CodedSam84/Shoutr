module ShoutHelper
  def like_button(shout)
    if current_user.liked?(shout)
      link_to "unlike", unlike_shout_path(shout), method: :delete, class: "like-padding-left"
    else
      link_to "like", like_shout_path(shout), method: :post, class: "like-padding-left"
    end
  end

  def auto_link(text)
    text.gsub(/@\w+/) { |mention| link_to mention, user_path(mention[1..-1])}.html_safe
  end

  def shout_form_for(content_type)
    form_for Shout.new do |f|
      f.hidden_field(:content_type, value: content_type) +
      f.fields_for(:content) { |c| yield c } +
      f.submit("Post shout")
    end
  end
end

