class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :creator, index: true
      t.string :name

      t.timestamps
    end
  end
end
