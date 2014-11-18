class CreateBrothers < ActiveRecord::Migration
  def change
    create_table :brothers do |t|
      t.string :name
      t.integer :year
      t.references :pledge_class, index: true

      t.timestamps
    end
  end
end
