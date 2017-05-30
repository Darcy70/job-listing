class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :newest_first, lambda { order("created_at DESC")}
  scope :published, -> { where(is_hidden: false)}
  scope :random5, -> { order("RANDOM()").limit(5) }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

end
