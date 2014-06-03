class AddLicenseAndHotDrinksAndFoodToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :license, :boolean
    add_column :businesses, :hot_drinks, :boolean
    add_column :businesses, :food, :boolean
  end
end
