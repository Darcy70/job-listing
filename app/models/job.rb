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

class Job < ApplicationRecord

  has_many :resumes, dependent: :destroy
  has_many :users, through: :resumes
  has_many :collections, dependent: :destroy
  belongs_to :location



  scope :published, -> { where(is_hidden: false)}

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :title, presence: { message: "You need to provide a job title."},
  length: 3..15
  validates :description, presence: {:message => "Description is needed"}
  validates :contact_email, presence: {:message => "Email is needed"},
  :format => {:with => EMAIL_REGEX, message: "The email format has to be right"}

  validates_numericality_of :wage_lower_bound, :wage_upper_bound

  validates :wage_lower_bound, presence: { message: "You need to provide a lower bound"}, numericality:{ greater_than: 0, message: "It has to be above the zero"}
  validates :wage_lower_bound, numericality: { less_than: :wage_upper_bound, message: "It has to be below the upper bound"}
  validates :wage_upper_bound, presence: { message: "You need to provide a upper bound"}, numericality:{ greater_than: :wage_lower_bound, message: "It has to be above the lower bound"}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

end
