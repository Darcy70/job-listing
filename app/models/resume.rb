class Resume < ApplicationRecord

  belongs_to :user
  belongs_to :job

  validates :content, presence: { message: "Relative content is needed."}
  validates :attachment, presence: { message: "Resume in PDF type is needed. "}

  mount_uploader :attachment, AttachmentUploader


end
