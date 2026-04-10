class PostLike < ApplicationRecord
  belongs_to :post, counter_cache: :likes_count

  validates :session_id, presence: true, uniqueness: { scope: :post_id }
end
