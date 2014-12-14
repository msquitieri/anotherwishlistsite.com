class AddReservedFlagToItem < ActiveRecord::Migration
  def change
    add_column :items, :reserved, :boolean, default: false
  end
end
