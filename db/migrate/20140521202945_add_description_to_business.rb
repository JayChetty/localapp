class AddDescriptionToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :description, :text
    add_column :businesses, :verified, :boolean
    add_column :businesses, :type, :string
  end
end
