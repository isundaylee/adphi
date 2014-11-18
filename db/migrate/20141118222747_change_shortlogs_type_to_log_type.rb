class ChangeShortlogsTypeToLogType < ActiveRecord::Migration
  def change
    rename_column :shortlogs, :type, :log_type
  end
end
