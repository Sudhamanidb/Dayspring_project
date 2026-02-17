class AddOrderToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_reference :customers, :order, foreign_key: true
  end
end
