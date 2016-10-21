class ChangeColumnNameInWork < ActiveRecord::Migration
  def change
    rename_column :works, :type, :work_type
  end
end
