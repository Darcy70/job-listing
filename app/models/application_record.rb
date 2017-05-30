class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :newest_first, lambda { order("created_at DESC")}
  scope :published, -> { where(is_hidden: false)}
  scope :random5, -> { order("RANDOM()").limit(5) }

end
