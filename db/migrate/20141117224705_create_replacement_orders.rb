class CreateReplacementOrders < ActiveRecord::Migration
  def change
    create_table :replacement_orders do |t|
      t.references :action_plan, index: true
      t.string :cr
      t.string :list_price
      t.string :product_code
      t.string :product_desc
      t.string :quantity
      t.string :status

      t.timestamps
    end
  end
end
