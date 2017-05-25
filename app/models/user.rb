# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default(FALSE)
#  name                   :string
#  is_website_admin       :boolean          default(FALSE)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  validates :name, presence: { message: "We need a name please." }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :resumes
  has_many :jobs, through: :resumes
  has_many :collections
  has_many :collected_jobs, :through => :collections, :source => :job





  def is_admin?
    is_admin
  end

  def is_website_admin?
    is_website_admin
  end

  def is_member_of?(job)
    collected_jobs.include?(job)
  end

  def add_collection!(job)
    collected_jobs << job
  end

  def remove_collection!(job)
    collected_jobs.delete(job)
  end

end
