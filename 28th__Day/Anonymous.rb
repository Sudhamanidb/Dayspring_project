# Anonymous methods :

# closure

def wednesday
    yield
end

wednesday{puts " 28th day class on wednesday"}

# --------------------------------

def wednesday1
    yield "class_notes","dayspring" 
end

wednesday1 do |*args|
    *args.each_cons(2) do |a,b|   
        puts "I am writing #{a} in #{b}"
    end 
    # puts *args.class # array
end

# Task to explaore

# wednesday1 do |*args|
#     *args.each_cons_with do |a,b|   
#     puts "I am writing #{a} in #{b}"
#     end 
#     # puts *args.class # array
# end


# ------------------------


def wednesday2
    yield
    yield
end

wednesday2{puts " first yield "}
wednesday2{puts " second yield "}

# o/p
# first yield
# first yield
# second yield
# second yield

# def wednesday3
#     yield
#     yield
# end

# wednesday3{puts " first yield "}{puts " second yield "}  #ERROR-->MULTIPLE BLOCKS not allowed
# ruby will allow 1 yield for 1 block (limitation of blocks)

puts "---------------------------------------------"

p = Proc.new{puts "statement inside prod.new"} # generating proc 
p.call # calling proc


p1 = Proc.new{|a| puts " statement inside paramerized proc : #{a}"} #generating proc with parameters
p1.call("hello Sudhamani you are selected !!!")  #o/p:  statement inside paramerized proc : hello Sudhamani you are selected !!!
p1.call # o/p statement inside paramerized proc :  (#--> If you did not pass parameters also will get output )

# If you did not pass parameters also will get output and also it will accept multiple parameters
puts"-------------------------------------------"

# def demo(para1,para2)
#     para1.call
#     para1.call
# end

# p3 = Proc.new{ puts "hello sudha "}

# p4 = Proc.new{ puts "hello sudhamani "}
# demo(p3,p4)


# def demo22
#     p5 = Proc.new{return "returning the sttmt in proc"} # proc has the ability to return from the calling method
#     p5.call
#     "hello you are inside demo22"
# end

# puts demo22()

#----------------------------------------------------------------------

# LAMDA OPERATOR" -> "

# instead of PRoc.new we are using "->"

l = ->{puts "lamda oprator"}
l.call

# parametorised lamda

l1 = ->(d){ puts "#{d} is my company"}
l1.call("dayspring")

# l1 = ->(d){ puts "#{d} is my company"}
# l1.call()  # o/p wrong number of arguments (given 0, expected 1) (ArgumentError)

l1 = ->(d,e){ puts "#{d} is my #{e} company"}
l1.call("efd","frdc") 


def demo22
    p5 = ->{return "returning the sttmt in proc"} # this will return from the lamda without returning the statement
    p5.call
    "hello you are inside demo22" # this will return
end
puts demo22()

# proc and lamda is object 
# block is not an object