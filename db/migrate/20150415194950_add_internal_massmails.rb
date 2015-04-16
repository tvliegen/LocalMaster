class AddInternalMassmails < ActiveRecord::Migration
  def change
    add_column :internal_massmails, :title, :string
    add_column :internal_massmails, :description, :string
    add_column :internal_massmails, :author, :string
    add_column :internal_massmails, :subject, :string
    add_column :internal_massmails, :content, :string
    add_column :internal_massmails, :distributionid, :string
    
  end
end
