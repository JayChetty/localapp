class AddAdminToOwner < ActiveRecord::Migration
  def change
    add_column :owners, :admin, :boolean
  end
end
