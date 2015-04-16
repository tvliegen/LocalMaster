class CreateInternalMassmails < ActiveRecord::Migration
  def change
    create_table :internal_massmails do |t|

      t.timestamps
    end
  end
end
