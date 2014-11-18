class AddCurrentToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :current, :boolean
  end
end
