class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.belongs_to :owner
      t.belongs_to :business
      t.string :description
      
      t.timestamps
    end

    add_index :ownerships, :owner_id
    add_index :ownerships, :business_id
  end
end
