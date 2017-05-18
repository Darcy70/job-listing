class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :newest_first, lambda { order("created_at DESC")}


end
