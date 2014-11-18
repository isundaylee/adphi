class CreateShortlogs < ActiveRecord::Migration
  def change
    create_table :shortlogs do |t|
      t.integer :type
      t.text :content
      t.references :brother, index: true

      t.timestamps
    end
  end
end
