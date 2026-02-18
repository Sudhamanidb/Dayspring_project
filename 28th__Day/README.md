# Day 28 : Anonymous Methods, Yield, Proc, Lambda & Metaprogramming(Singleton)

## 1. Anonymous Methods

Anonymous methods are methods without names.
In Ruby they are implemented using:

* Blocks
* Proc
* Lambda

Closure: a block can access variables from its surrounding scope.
* Proc and Lambda are objects
* Block is not an object
* Singleton class, metaclass, eigenclass refer to same concept
---

## 2. Blocks and `yield`

`yield` executes the block passed to the method.

```ruby
def wednesday
  yield
end

wednesday { puts "28th day class on wednesday" } 
# output: 28th day class on wednesday
```

### Passing parameters to block

```ruby
def wednesday1
  yield "class_notes", "dayspring"
end

wednesday1 do |*args|
  args.each_cons(2) do |a, b|
    puts "I am writing #{a} in #{b}"
  end
end
# output: I am writing class_notes in dayspring
```

### Multiple yield calls

```ruby
def wednesday2
  yield                   # first yield
  yield                 # first yield
end

wednesday2 { puts "first yield" }

```
* One block can be executed multiple times
* Only one block allowed per method call
* Block is not an object
* `yield` can pass parameters

---

## 3. Proc

Proc is an object representation of a block.

```ruby
p = Proc.new { puts "statement inside proc.new" }
p.call                                 # output: statement inside proc.new
```

### Parameterized Proc

```ruby
p1 = Proc.new { |a| puts "statement inside parameterized proc: #{a}" }
p1.call("hello")                              # statement inside parameterized proc: hello
p1.call                                    # statement inside parameterized proc:
```

* Arguments are optional
* Accepts multiple arguments
* Proc `return` exits from the calling method
* Proc is an object

---

## 4. Lambda (`->`)

Lambda is a special Proc with strict behavior.

```ruby
l = -> { puts "lambda operator" }
l.call                              # output: lambda operator
```

### Parameterized Lambda

```ruby
l1 = ->(d, e) { puts "#{d} is my #{e} company" }
l1.call("dayspring", "best")                     # output: dayspring is my best company
```
* Strict arguments
* `return` exits only from lambda
* Lambda is an object

---

## 5. Proc vs Lambda

| Proc                  | Lambda              |
| --------------------- | ------------------- |
| Flexible arguments    | Strict arguments    |
| Returns from method   | Returns from lambda |
| Created with Proc.new | Created with ->     |

---

## 6. Singleton Methods (Metaprogramming)

Method available only for one object.

```ruby
class Animal
  def Dog
    puts "I am a dog"
  end
end

a1 = Animal.new

a1.singleton_class.class_eval do
  def Cat
    puts "I am a cat"
  end
end

class << a1
  def Tiger
    puts "I am a tiger"
  end
end

a1.Cat    # output: I am a cat
a1.Dog     # output: I am a dog
a1.Tiger  # output: I am a tiger
```
* Singleton method works only for that object
* Other objects cannot access it
* Using `singleton_class` we can access both instance and singleton methods

---

## 7. class_eval vs instance_eval

### class_eval → adds instance methods

```ruby
class Fruits; end

Fruits.class_eval do
  def apple
    puts "Bruhh....!! I am good for health"
  end
end

Fruits.new.apple                     # output: Bruhh....!! I am good for health
```

### instance_eval → adds singleton method

```ruby
f2 = Fruits.new

f2.instance_eval do
  def appleeee
    puts "Bruhh....!! I am good for healthhhhhhhhhhhhhh"
  end
end

f2.appleeee                       # output: Bruhh....!! I am good for healthhhhhhhhhhhhhh
```

### Difference

* class_eval works on class
* instance_eval works on object
* class_eval allows object instantiation anywhere
* instance_eval requires object first

---

## 8. Ancestor Chain

```ruby
puts Fruits.singleton_class.ancestors
# output:
# <Class:Fruits>
# <Class:Object>
# <Class:BasicObject>
# Class
# Module
# Object
# Kernel
# BasicObject
```

---

## 9. Access to Instance Variables

```ruby
class Tree
  def initialize(name)
    @name = name
  end
end
t1 = Tree.new("sudhamani")

t1.instance_eval { puts @name }     # output: sudhamani

t1.singleton_class.class_eval do         # output: nil
  puts @name
end

```
* instance_eval can access private instance variables
* singleton_class.class_eval cannot

---

## 10. Yield in Rails Layout

```erb
<%= yield %>
<%= yield :head %>
```

Flow:

1. Request comes to controller
2. application layout loads
3. yield inserts view content
4. yield :head inserts named content

* If yield is removed nothing will render
* application.rb loads first when app restarts

---

## 11. prepend

* Module methods take precedence
* Changes method lookup chain
* Used for decorators and overrides

```ruby
module Greeting
  def hello
    puts "from module"
  end
end

class Person
  prepend Greeting
  def hello
    puts "from class"
  end
end

Person.new.hello                # output: from module
```
---


