class AddAttachmentLogoToPartners < ActiveRecord::Migration[5.0]
  def self.up
    change_table :partners do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :partners, :logo
  end
end
