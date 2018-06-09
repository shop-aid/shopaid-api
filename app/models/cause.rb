class Cause < ApplicationRecord
  # Paperclip
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  has_attached_file :poster, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\z/

  # Tags
  acts_as_taggable

  include RailsSortable::Model
  set_sortable :sort

  has_many :donations

  has_many :causes, through: :targets
  has_many :targets
end
