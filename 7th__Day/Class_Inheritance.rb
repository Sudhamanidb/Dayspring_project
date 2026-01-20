#INHERITANCE

# Accesing variable from parent class using using SUPER keyword
class Employee
  def emp_details
    print "Enter your name: "
    @name = gets.chomp   # chomp to remove newline
    puts "Welcome to Dayspring #{@name}"
  end
end

class MyClass < Employee
    def puts(str)
        super(str.upcase)  # calls the original puts method with uppercase string
    end
    def puts1
        puts "hello from puts1 method in MyClass"
    end
    def emp_details
        super   # calls Employee#emp_details
        puts "#{@name}, you are the first person selected for FULLTIME"
    end
end

obj = MyClass.new
obj.emp_details
puts "------------------------------------------------"
obj.puts1
obj.puts("hello world from MyClass")

puts "------------------------------------------------"

# 🔍 ancestors
puts "Ancestors of MyClass:"
puts MyClass.ancestors

puts "------------------------------------------------"

# 🔍 respond_to?
puts "Does obj respond to emp_details? #{obj.respond_to?(:emp_details)}"
puts "Does obj respond to name? #{obj.respond_to?(:name)}"
puts "Does obj respond to puts? #{obj.respond_to?(:puts)}"
puts "Does obj respond to puts? #{obj.respond_to?(:capitalize)}"
puts "-------------------------------------------------"



class Parent
  def initialize
    puts "Welcome to Parent class"
    @college = "St. Anne's"
  end
end

class Child < Parent
  def initialize
      super
  puts "Welcome to Child class"
  end
  def child_method
    print "Enter your name: "
    @name = gets.chomp
    print "Enter your email: "
    @email= gets.chomp

    puts "Name: #{@name}"
    puts "College: #{@college}"
    puts "Email: #{@email}"
  end
  
end

c1 = Child.new
c1.child_method
puts "------------------------------------------------------------"


# WITH PASSING SOME ARGUMENTS

class Parent1
  def initialize(college_name)
    puts "Welcome to Parent class"
    @college = college_name
  end
end

class Child < Parent1
    def initialize
        super
        puts college_name
    puts "Welcome to Child class"
  end

  def child_method
    print "Enter your name: "
    @name = gets.chomp
    print "Enter your email: "
    @email= gets.chomp
    print "Enter your age: "
    @age= gets.chomp

    puts "---------------------------"
    puts "Name: #{@name}"
    puts "College: #{@college}"
    puts "Email: #{@email}"
    puts "Age: #{@age}"
  end 
end

c1 = Child.new("st.Anne's")
c1.child_method
puts "------------------------------------------------"


class Addition
    def sample_method(n1,n2)
        puts (n1+n2)
    end
end

class Multiplication<Addition
    def sample_method(n1,n2)
      super
      p (n1*n2)
    end
end
m1=Multiplication.new
p "enter the value of n1:"
n1= gets
p "enter the value of n2:"
n2= gets
m1.sample_method(n1,n2)


