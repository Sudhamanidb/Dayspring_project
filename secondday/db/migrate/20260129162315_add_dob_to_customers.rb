class AddDobToCustomers < ActiveRecord::Migration[8.1]
  def change
    add_column :customers, :dob, :date
  end
end
