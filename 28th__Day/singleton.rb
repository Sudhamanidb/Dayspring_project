# Topic under metaprogramming
# singleton

class Animal
    def Dog
        puts "I am a dog"
    end
end
# If i want to access particular method only with that one instance
a1 = Animal.new

# ---------> singleton with using class eval <-----------------------------------
a1.singleton_class.class_eval do
    def Cat
        puts "I am a cat"
    end  
end

a1.Cat
a1.Dog

# If we use singleton we can access that method only with that particular object
# Using singleton_class object we can access any method (methods inside class and singleton method) 
# but we can access singleton method only using that "one object" not with any other object


# --------->singleton without using class eval <-----------------------------------
class << a1 
    def Tiger
        puts "I am a tiger "
    end
end
a1.Tiger


------------------------------------------------------------------------------
# Normal

class Fruits
end
f1=Fruits.new
Fruits.class_eval do  # always use class name to evaluate it
    def apple
        puts "Bruhh....!! I am good for health "
    end
end
f1=Fruits.new
f1.apple

# Fruits.instance_eval do  # 
#     def applee
#         puts "Bruhh....!! I am good for healthhhhhhhhhhhhhh "
#     end
# end
# f2.applee  #ERROR -> o/p:  undefined method `apple' for an instance of Fruits (NoMethodError)

----------------> Diff b/w class_eval and instance_eval <---------------------------------
---------------------------------------------------------------------------------------
   class_eval                      |        instance_eval
                                   |
  * we should pass class name in   |  * we should pass object of class                               
    with class_eval                |    with instance_eval, if we pass class 
                                   |    name it will give->(NoMethodError)

  * we can instantiate obj anywhere| * we should instantiate befor using it
                                   |   in instance_eval
  *

f2=Fruits.new
f2.instance_eval do  # 
    def appleeee
        puts "Bruhh....!! I am good for healthhhhhhhhhhhhhh "
    end
end
f2.appleeee  #o/p:  undefined method `apple' for an instance of Fruits (NoMethodError)

puts Fruits.singleton_class.ancestors

# o/p: 
<Class:Fruits>
<Class:Object>
<Class:BasicObject>
Class
Module
Object
Kernel
BasicObject

-----------------------------------------------------------------

class Tree
    def initialize(name)
        @name = name
    end
end

t1 = Tree.new("sudhamani")
t1.instance_eval do
    puts @name
end

t1.singleton_class.class_eval do   # we should use class_eval with singleton_class
    puts @name
end


# instance_eval--> has access to the private variable
# singleton_class.class_eval --> do not have access to the private variable


------------------------------------------------------------------------
OUTOUTS :

I am a cat
I am a dog
I am a tiger
Bruhh....!! I am good for health
Bruhh....!! I am good for healthhhhhhhhhhhhhh
sudhamani



