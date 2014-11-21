class AddPositionToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :position, :integer
  end
end
