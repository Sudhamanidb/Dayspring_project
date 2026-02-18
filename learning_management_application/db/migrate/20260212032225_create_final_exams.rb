class CreateFinalExams < ActiveRecord::Migration[8.1]
  def change
    create_table :final_exams do |t|
      t.date :exam_date
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
