class ShoutSearchQuery
  def initialize(term:)
    @term = term
  end

  def to_relation
    Shout.
      joins("INNER JOIN text_shouts ON content_type = 'TextShout' AND content_id = text_shouts.id").
      where("body ILIKE ?", "%##{term}%")
  end

  private

  attr_reader :term
end