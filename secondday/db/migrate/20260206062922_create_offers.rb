class CreateOffers < ActiveRecord::Migration[8.1]
  def change
    create_table :offers do |t|
      t.string :off_name
      t.integer :discount
      t.boolean :status

      t.timestamps
    end
  end
end
