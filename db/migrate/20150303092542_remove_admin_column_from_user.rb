class RemoveAdminColumnFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :admin, :boolean
  end
end
