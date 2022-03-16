class ShoutSearchQuery
  def initialize(term:)
    @term = term
  end

  def to_relation
    matching_shouts_for_text_shout.
      or(matching_shouts_for_photo_shout)
  end

  private

  attr_reader :term

  def matching_shouts_for_text_shout
    Shout.where(content_type: "TextShout", content_id: matching_text_shouts)
  end

  def matching_shouts_for_photo_shout
    Shout.where(content_type: "PhotoShout", content_id: matching_photo_shouts)
  end

  def matching_text_shouts
    TextShout.where("body ILIKE ?", "%#{term}%").select(:id)
  end

  def matching_photo_shouts
    photo_shouts_joins_with_active_storage.where("filename ILIKE ?", "%#{term}%").select(:id)
  end

  def photo_shouts_joins_with_active_storage
    PhotoShout.
      joins("INNER JOIN active_storage_attachments ON 
      record_id = photo_shouts.id INNER JOIN active_storage_blobs ON 
      active_storage_blobs.id = blob_id")
  end

end
