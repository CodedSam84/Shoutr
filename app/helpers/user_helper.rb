module UserHelper
  def follow_button(user)
    if current_user.following?(user)
      button_to "unfollow", unfollow_user_path(user), method: :delete
    else
      button_to "follow", follow_user_path(user)
    end
  end
end