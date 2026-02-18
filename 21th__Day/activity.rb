# 1. Write Ruby code to store a user’s name and age, and print a sentence using string interpolation.

name = "Sudhamani"
age = 22
puts " I'm #{name} , #{age} years old"

# 2. Write Ruby code to take user input for age using gets, remove the newline, convert it to an integer, and print the age after 5 years.

age = gets.chomp.to_i
puts (age+5)

# 3. Write Ruby code that prints the numbers 1 2 3 on the same line, and then prints the same numbers on separate lines.

i=1
while i < 4
    puts i 
    i+=1
end

j=1
while j<4
    print j 
    j+=1
end

# 4. What will be the output of the following Ruby code?
# name = "rails"
# puts name.capitalize
# o/p  RAILS

# 5. Write Ruby code to iterate over the array [10, 20, 30] and print each value.

arr= [10, 20, 30]
arr.each do |n|
    puts n
end

# 6. Write Ruby code to convert the array [1, 2, 3, 4, 5, 6, 7, 8] into [2, 4, 6, 8].

arr1 = [1,2,3,4,5,6,7,8]
arr1.each do |n|
    if n.even?
        print n
    end
end

# 7. Write Ruby code to select only even numbers from the array [1, 2, 3, 4, 5, 6].

arr2 = [1, 2, 3, 4, 5, 6]
even = arr2.select{|n| n.even?}
puts even

puts "------------------------------"
# 8. Write Ruby code to find the sum of numbers in the array [5, 10, 15].

arr3=[5, 10,  15]
i=0
arr3.each do |n|
    i+=n
end
puts "#{i}"

# 9. Write Ruby code to check if any number in [1, 3, 5, 6] is even and if all numbers in [2, 4, 6] are even.

arr3 = [1, 3, 5, 6]
puts arr3.any? { |n| n.even? }
puts arr3.all? { |n| n.even? }

# 10. Write Ruby code to print "Pass" if marks are greater than or equal to 40, otherwise print "Fail".

marks=50
if marks>40
    puts "Pass"
else
    puts "Fail"
end

# 11. Write Ruby code to print "Not Active" unless a variable active is true.

active = false
unless active
    puts "Not Active"
end

# 12. Write Ruby code to print numbers from 1 to 5 using a while loop.

i=1
while i<6
    print i
    i+=1
end
puts("------------------------------------------")

# 13. Write Ruby code to print numbers from 1 to 5 using an until loop.

i=1
until i>5
    print i 
    i+=1
end

# 14. Write Ruby code using loop and break to print numbers starting from 1 and stop when the number reaches 4.

i=1
loop do
    puts i
    i+=1
    break if i==4
end

# 15. Write a Ruby class Student with attributes name and age, and a method details that prints the name and age.

class Student
    def initialize(name,age)
        @name = name
        @age = age
    end
    def stud_details
        puts "Name = #{@name}"
        puts "Age = #{@age}"
    end
end
s1= Student.new("sudhamani",22)
s1.stud_details

# 16. Create two Ruby objects, print their object_id, and check whether the object IDs are the same or different.

name1 = "radha"
name2 = "krishna"
puts name1.object_id
puts name2.object_id

# 17. Write Ruby code to print the ancestor chain of a custom class Student.

a=23
puts a.ancestor

# 18. Write a Rails route that handles a GET request and maps to the index action of StudentsController.

resources :students


# 19. Write a Rails controller action index that fetches all students and stores them in an instance variable.

def index
    @Students = Student.all
end

# 20. Write a Rails model validation to ensure the email attribute is present for a Student.

validates :email, presence:true 

# 21. Write a Rails scope to fetch records created within the last 7 days.

scope :rec_fetch, -> where{("created_at < ?"),7.days.ago} 

# 22. Write the Rails console command to create a new student with a name and email.

Student.create(name: "sudhamani", email:"sudhamanidb11@gmail.com")

# 23. Write a private strong parameters method in a Rails controller to permit name and email for Student.

params.require(:student).permit(:name,:email)

# 24. Write Rails model code to allow multiple file uploads for a record.

has_many_attached :stud_pic

# 25. Write Rails model code to enable rich text content for a description field

has_rich_text :description
