class Course < ApplicationRecord
  belongs_to :student

  before_validation :assign_random_student, on: :create

  private

  def assign_random_student
    self.student_id ||= Student.pluck(:id).sample
  end

end
