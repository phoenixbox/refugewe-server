class VisionRecord < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user, dependent: :destroy
end
