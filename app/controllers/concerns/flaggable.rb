module Flaggable
  extend ActiveSupport::Concern

  included do
    has_many :flagged_as_flagger, as: :flagger, class_name: 'Flagged'
    has_many :flagged_as_flaggable, as: :flaggable, class_name: 'Flagged'
  end

  def flag!(flaggable)
    Flagged.create!(flaggable: flaggable, flagger: self)
  end
end
