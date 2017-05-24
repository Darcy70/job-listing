# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  sort       :integer
#  is_hidden  :boolean          default(FALSE)
#  is_lock    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :jobs
end
