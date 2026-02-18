class User
    attr_accessor :role
    # def admin?
    #     role == "admin"
    # end
    # def guest?
    #     role == "guest"
    # end
    # def member?
    #     role == "member"
    # end

    ["admin","guest","member"].each do |role_name|
        # defin_method(parameter-->is a metthod name)
        define_method(role_name) do # or define_method("#{role_name?}") ---> if we use this in method call also we need to use "?"
            puts role == role_name
        end
    end

    def method_missing(method_name,*args) #--> method missing act as an instance method and we can access globaly
        puts("Method does not exist")  #-->*args aan handle method which is missing 
    end

end

u1 =User.new()
u1.role = "admin"
puts u1.admin

u1.role = "developer"
puts u1.developer

u1.role = "member"
puts u1.member

puts"------------------------------"

# ---------> method_missing / dynamic dispatch <--------------------------------------------
# we can use method missing when we not sure about what method is going to call
class Vender
    def method_missing(method_name,*args) 
        if method_name.to_s.start_with?("find_by")
            # str = method_name.to_s.substring(0, method_name.length())
            str = method_name.to_s[0,method_name.length]
           
            puts "#{str} : #{args.first}"
        end
    end
end

v1=Vender.new()
puts v1.find_by_email("sudhaa mani db")

puts "---------------------------------------------"

# -----------------------> open class <-----------------------------

# we can open existing any class (ex : kernal,object)and can add my own defination (modification)
# monkey patching : opening methods of redefining class and doing some changes

# -------------------> monkey patching <--------------------

class String
    def upcase
        str ="UPCASE OVERWRITEN"
    end

    def custome_douncase
        downcase
        puts "inside custome_douncase method"
    end
end

s1=String.new
puts s1.upcase
puts s1.custome_douncase

puts"------------------------------"
# work sround to access private method--->basic.obj.send:private_method
# pass method name to  it---> on any obj which is going to dcide on runtime at that time use .send and pass method name as parameter

#----------> .send <---------------------------------

class Messanger

    def email(msg)
        "email is sent : #{msg}"
    end

    def sms(msg)
        "sms msg is sent : #{msg}"
    end

    def teligram(msg)
        "teligram msg is sent : #{msg}"
    end

    def watsapp(msg)
        "watsapp msg is sent : #{msg}"
    end
    
    private
    def own
        "hey...let me have some privacy"
    end
end

m1 = Messanger.new
method_name = :sms #("Hi you are selected ")
puts m1.send(method_name," you are selected ")
puts m1.send(:own)  # we can able to access private method if i use .send
puts m1.__send__(:own) # alias name to .send is .__send__


puts "----------------------------------------"

# INTERPOLATION

# puts m1.methods
# puts m1.class
# puts m1.inspect


# -------> eval <-----------
# class_eval ---> all methods
# instance_eval ---> all instance

class Sample_Eval
    Sample_Eval.class_eval do 
        def demo
            "inside sample demo"
        end
    end
    Sample_Eval.instance_eval do #Adds 'sam' as a singleton method on the Sample_Eval class object
        def sam
            "inside sample sam"
        end
    end
end
    
# same as instance , behave as an instance method
s1 = Sample_Eval.new
puts s1.demo
puts Sample_Eval.sam



# OUTPUT


true

Method does not exist

true

------------------------------
find_by_email : sudhaa mani db

---------------------------------------------
UPCASE OVERWRITEN
inside custome_douncase method

------------------------------
sms msg is sent :  you are selected
hey...let me have some privacy
hey...let me have some privacy
----------------------------------------
inside sample demo
inside sample sam