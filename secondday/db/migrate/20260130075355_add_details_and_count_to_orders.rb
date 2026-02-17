class AddDetailsAndCountToOrders < ActiveRecord::Migration[8.1]
  def change
    add_column :orders, :details, :string
    add_column :orders, :count, :integer
  end
end
