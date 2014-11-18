class AddKerberosToBrothers < ActiveRecord::Migration
  def change
    add_column :brothers, :kerberos, :string
  end
end
