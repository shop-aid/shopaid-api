class Partner < ApplicationRecord
  include RailsSortable::Model

  # Paperclip
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  set_sortable :sort
end
