class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.integer :kind
      t.integer :value
      t.references :brother, index: true

      t.timestamps
    end
  end
end
