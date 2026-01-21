# CONDITIONAL STATEMENTS
# -->IF

stock=20
is_availavle=false

if stock > 0
    is_available=true
else
    print ("Item is not available")
end


# TERNARY OPERATOR
# condition ? true_case : false_case

is_active = false
print is_active ? "Item is available" :"Item not available"
# OUTPUT: Item not available


# IF-ELSIF-ELSE

price=450
discount=0
if price >= 100 && price < 200
    discount=10
elsif price > 200 && price < 500
    discount = 20
elsif price > 500 && price < 1000
    discount = 35
end

puts " you got #{discount}% discount"

p"----------------------"

case price
when 100..200
    discount=10
when 201..500
    discount=20
when 501..1000
    discount=35
else
    discount=0
end
puts " you got #{discount}% discount"
p"----------------------"



price=450
discount=0

case 
when price >= 100 && price < 200
    discount=10
when price > 200 && price < 500
    discount = 20
when price > 500 && price < 1000
    discount = 35
end

puts " you got #{discount}% discount"

p"------------------------------"

# --> if we use conditional operator we do not have to mention price with case
# --> if we use range with when ,then we should mention price(col_value)

stock = 14
unless stock > 0
    puts"no stock available "
else
    puts" stock available"
end

puts -------------------------

email = "tfghbn@gmail.com"
 unless email.nil?# || email==false
    puts "email is present"
else
    puts "no email"
end
puts "-----------------------------"

email = nil
unless email
    puts "email is present"
else
    puts "no email"
end

puts "-----------------------------"
email = false
unless email
    puts "email is present"
else
    puts "no email"
end
puts "-----------------------------"


class Person
    def initialize(name,age)
        @name=name
        @age=age
    end

    protected
    def display_details
        puts "Name: #{@name}"
        puts "Age: #{@age}"
        e1.
        
    end
end

class Employee < Person
    
    def initialize(name,age,emp_id,dept)
        super(name,age)
        @emp_id=emp_id
        @dept=dept
    end

    private 
    def details
        super()
        puts "Employee ID: #{@emp_id}"
        puts "Department: #{@dept}"
        puts "Department: #{@dept}"
    end
end

e1=Employee.new("sudha",24,101,"IT")
e1.display_details

puts "------------------------"

# inside of the class you cannot able to access it,,,, it should be call  from public methods

class Animal
    def eating
        puts "Animal is eating"
    end
    protected
    
    def running
        d1.barking
        puts "Animal is running"
    end
end

class Dog < Animal
    private
    super
    def barking
        puts " Dog is Barking"
    end
end
d1= Dog.new
d1.barking
# /we cannot access private method directly  but there is workaround but normally NO

# outpu: conditional_stmt.rb:157:in `<class:Dog>': super called outside of method (NoMethodError)
        # from conditional_stmt.rb:155:in `<main>'


