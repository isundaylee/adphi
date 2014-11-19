class CreateAttendences < ActiveRecord::Migration
  def change
    create_table :attendences do |t|
      t.references :meeting, index: true
      t.references :brother, index: true
      t.references :creator, index: true
      t.integer :status

      t.timestamps
    end
  end
end
