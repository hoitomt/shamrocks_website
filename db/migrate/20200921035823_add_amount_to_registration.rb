class AddAmountToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :amount, :decimal, precision: 8, scale: 2
  end
end
