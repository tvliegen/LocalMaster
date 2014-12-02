class CreateJournalAttachment < ActiveRecord::Migration
  def change
    create_table :journal_attachments do |t|
      t.references :journal, index: true
      t.attachment :attachment

      t.timestamps
    end
  end
end
