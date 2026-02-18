class CreateInstructors < ActiveRecord::Migration[8.1]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :qualification
      t.integer :experience

      t.timestamps
    end
  end
end
