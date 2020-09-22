class AddChargeIdToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :charge_identifier, :string
  end
end
