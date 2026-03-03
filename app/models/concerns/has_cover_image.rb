module HasCoverImage
  extend ActiveSupport::Concern

  def cover_thumb
    return unless cover_image.attached?

    cover_image.variant(resize_to_fill: [ 400, 300 ])
  end

  def cover_medium
    return unless cover_image.attached?

    cover_image.variant(resize_to_fill: [ 800, 450 ])
  end

  def cover_large
    return unless cover_image.attached?

    cover_image.variant(resize_to_fill: [ 1200, 675 ])
  end
end
