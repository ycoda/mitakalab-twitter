class Tweet < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, :content, presence: true
end
