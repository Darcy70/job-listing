# == Schema Information
#
# Table name: jobs
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  contact_email    :string
#  wage_lower_bound :integer
#  wage_upper_bound :integer
#  is_hidden        :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  company          :string
#  category_id      :integer
#  location_id      :integer
#

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
