class AddAttachmentPosterToCauses < ActiveRecord::Migration[5.0]
  def self.up
    change_table :causes do |t|
      t.attachment :poster
    end
  end

  def self.down
    remove_attachment :causes, :poster
  end
end
