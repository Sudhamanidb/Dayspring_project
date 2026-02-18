class Course < ApplicationRecord
  belongs_to :instructor
  has_one :final_exam
  
  has_many :enrollments
  has_many :students, through: :enrollments
  has_and_belongs_to_many :tags
end
