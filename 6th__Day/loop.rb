"MAIN PROJECT CHANGES HAVE DONE ........ SO YOU CAN GO TO SECONDDAY FOLDER AND SEE "


arr=[2,4,6,8,10,12]
for i in 10..15  #-->.. means opening the loop/for i<13
    print i
    i+=1   #in ruby for loop auto increament will not work
end


puts "------------------"
i=0 # we need to intialize in while loop and until condition is true it will exicute
while i<=10
    puts i
    i+=1;
end


puts "------------------"
k=0
loop do
    puts " student : #{k}"
    k+=1
break if k>30  # it will exit the loop if break condition is true
end



#UNTIL--> OPPOSITE of while
c=0
until c>15 do
    puts c
    c+=1
end

REDO AND NEXT next--> it will skip the current iteration and move to next iteration

loop=1
for i in 1..5 
    puts i
    k=i
    while k>=i && k<i
        puts i
        k-=1
        redo
    end   
    # break if loop>2  # it will repeat the current iteration
    loop+=1
break if loop>6
end


# EACH MAP ALL SELECT REJECT INJECT

# SELECT
# it will select the values based on the condition provided in the block
#  we can use "{ }" instead of do and end
# inside place of pipe symbole we can give anything like variable

print arr
puts
print arr.select {|num| num>4}
puts "------------------"

# assign it to one var and print
res=arr.select!{|num| num>4}
puts res
puts "------------------"

# REJECT
res1=arr.reject!{|num| num>2}
puts res1
puts "------------------"
print arr

# DIFFERENCE B/W SELECT/REJECT AND SELECT!/REJECT!

# select! and reject! are destructive methods-->! will make the method destructive
# original array is modified in both select! and reject! methods
# select! will keep the values which are true based on the condition provided in the block  
# reject! will remove the values which are true based on the condition provided in the block
# select will return the values which are true based on the condition provided in the block
# reject will return the values which are false based on the condition provided in the block

print "------------------------"
# ANY? AND ALL?

arr2=[1,2,3,4,5]
arr.any? {|num| num>5}  # it will return true if any one of the value is true based on the condition provided in the block
arr.all? {|num| num>0}  # it will return true if all the values are true based on the condition provided in the block


print "------------------------"
# MAP
# it will return a new array based on the operation provided in the block
arr3=arr2.map {|num| num**2}
print arr3
puts

arr4=arr2.collect {|num| num**2}
print arr4
puts

arr5= arr2.each{|num| num**2}
print arr5
puts
 
# map and collect are same
# each will return the original array
# map and collect will return a new array based on the operation provided in the block


