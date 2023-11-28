class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.string :order_id
      t.string :source_location
      t.string :target_location
      t.text :item_description
      t.integer :status, default: 0
      t.references :customer, foreign_key: { to_table: :users }
      t.references :delivery_partner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
