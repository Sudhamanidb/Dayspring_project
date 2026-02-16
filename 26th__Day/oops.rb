class Animal 
    
    # attr_accessor :name  ---->   getter setter -->abstraction encapsulation
    # attr_reader :name   ----> only get
    def initialize(name)
        @name = name
    end

    def name
        @name
    end

    def name=(new_name)  #--->setter method --> ruby allows operators in methods
        @name
    end


    def details
        puts "name is #{@name}" #string inter polation
    end
end

a1 = Animal.new("sudhamani")
puts a1.details
a1.name = "sudha"
print a1.name

puts"-------------------------------------------"
# module Title
#   def title_name
#     puts "Module Title: Book name method"
#   end
# end

# module Publish
#   def initialize(publisher_name)
#     @publisher = publisher_name
#     puts "Inside Publish initialize method"
#   end

#   def publisher_name_method
#     puts "Publisher name is #{@publisher}"
#   end
# end

# module Pages
#   def pages_info
#     puts "Pages module method"
#   end
# end

# class Book include Title, Publish, Pages

#   def self.author
#     puts "This is class method: Author info"
#   end

#   def initialize(price, publisher_name)
#     @price = price
#     super(publisher_name)
#   end

#   def price
#     puts "Book price is #{@price}"
#   end
# end


# Book.author

# b1 = Book.new(500, "Penguin")
# b1.price
# b1.title_name
# b1.publisher_name_method
# b1.pages_info

# puts Pages.ancestors

# notes diff of changing priority prepend---of module priority include is for _____
# diff ways of writing instance method -->self.method
                                    #    -->class

# dif b/w class and instance vari



# --------------

# Duck typing

class Example1
    def method1
        puts "Duck method 1"
    end
end

class Example2
    def method1
        puts "Duck method 2"
    end
end

def Print_Example(print_obj)
    print_obj.method1

end

Print_Example(Example1.new)
Print_Example(Example2.new)


