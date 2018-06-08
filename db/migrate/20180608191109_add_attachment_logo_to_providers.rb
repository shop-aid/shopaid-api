class AddAttachmentLogoToProviders < ActiveRecord::Migration[5.0]
  def self.up
    change_table :providers do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :providers, :logo
  end
end
