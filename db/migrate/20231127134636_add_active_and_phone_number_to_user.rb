class AddActiveAndPhoneNumberToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :is_active, :boolean, default: false
  end
end
