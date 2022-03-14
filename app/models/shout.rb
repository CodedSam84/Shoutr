class Shout < ApplicationRecord
  belongs_to :user
  belongs_to :content, polymorphic: true

  delegate :username, to: :user
end
