# == Schema Information
#
# Table name: resumes
#
#  id         :integer          not null, primary key
#  job_id     :integer
#  user_id    :integer
#  content    :text
#  attachment :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Resume < ApplicationRecord

  belongs_to :user
  belongs_to :job

  validates :content, presence: { message: "Relative content is needed."}
  validates :attachment, presence: { message: "Resume in PDF type is needed. "}

  mount_uploader :attachment, AttachmentUploader


end
