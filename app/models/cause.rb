class Cause < ApplicationRecord
  # Paperclip
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  # Tags
  acts_as_taggable

  include RailsSortable::Model
  set_sortable :sort
end
