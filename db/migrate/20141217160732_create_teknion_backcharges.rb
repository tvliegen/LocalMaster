class CreateTeknionBackcharges < ActiveRecord::Migration
  def change
    create_table :teknion_backcharges do |t|

      t.timestamps
    end
  end
end
