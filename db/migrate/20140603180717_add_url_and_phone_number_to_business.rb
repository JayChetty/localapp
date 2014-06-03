class AddUrlAndPhoneNumberToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :url, :string
    add_column :businesses, :phone_number, :string
  end
end
