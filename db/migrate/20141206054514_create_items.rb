class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :price
      t.string :notes
      t.string :image
      t.string :link
      t.integer :quantity
      t.integer :priority
      t.references :list, index: true

      t.timestamps
    end
  end
end
