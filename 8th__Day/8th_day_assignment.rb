
class Puts
  def puts
     "Hello from PutsDemo"
  end
end

class Display
  def display
    "Display method called"
  end
end

class Replace
  def replace
    "Replace method executed"
  end
end

class Round
  def round
    "Round method executed"
  end
end

class InstanceExec
  def instance_exec
    "Instance exec method executed"
  end
end


#  Object creation 

puts_obj     = Puts.new
display_obj  = Display.new
replace_obj  = Replace.new
round_obj    = Round.new
exec_obj     = InstanceExec.new


# Method Calls

puts puts_obj.puts
puts display_obj.display
puts replace_obj.replace
puts round_obj.round
puts exec_obj.instance_exec
puts "--------------------------" 

# respond_to?

puts puts_obj.respond_to?(:puts)
puts display_obj.respond_to?(:display)
puts replace_obj.respond_to?(:replace)
puts round_obj.respond_to?(:round)
puts exec_obj.respond_to?(:instance_exec)
puts "--------------------------" 

# checking ancestors
puts Puts.ancestors
puts "--------------------------" 
puts Display.ancestors


# output:
Hello from PutsDemo
Display method called
Replace method executed
Round method executed
Instance exec method executed
--------------------------
true
true
true
true
true
--------------------------
Puts
Object
Kernel
BasicObject
--------------------------
Display
Object
Kernel
BasicObject
