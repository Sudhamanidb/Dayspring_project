# Day 27 : Metaprogramming 

Ruby is a highly dynamic language that allows you to write code that defines, modifies, or extends itself at runtime. Instead of explicitly defining every method, Ruby allows you to create behavior dynamically while the application is running.

Metaprogramming some Abilities:

* Create methods dynamically
* Handle undefined method calls
* Modify existing classes
* Invoke methods dynamically
* Access private methods
* Define behavior at runtime
---

# 2. Dynamic Methods with `define_method`

Dynamic methods are created at runtime instead of being manually written in the source file.

### Ex: Creating Role-Based Methods Dynamically

```ruby
class User
  attr_accessor :role

  ["admin", "guest", "member"].each do |role_name|
    define_method(role_name) do
      role == role_name
    end
  end
end

u1 = User.new
u1.role = "admin"
puts u1.admin      # ->true

u1.role = "member"
puts u1.member     # ->true

u1.role = "guest"
puts u1.guest      # -> true
```

* `define_method` takes the method name as a parameter.
* Methods are created during runtime.
* Useful when method names follow a predictable pattern.
* If using `define_method("#{role_name}?")`, the method must be called with `?` (e.g., `u1.admin?`).

---

# 3. Handling Missing Methods with `method_missing`

`method_missing` allows Ruby to handle calls to undefined methods instead of raising an error.

### Normal ex:

```ruby
class User
  def method_missing(method_name, *args)
    puts "Method #{method_name} does not exist"
  end
end

u1 = User.new
u1.unknown_method
```

### Dynamic Dispatch ex:

`method_missing` can also be used to create dynamic methods like `find_by_*`.

```ruby
class Vendor
  def method_missing(method_name, *args)
    if method_name.to_s.start_with?("find_by_")
      attribute = method_name.to_s.sub("find_by_", "")
      puts "Finding by #{attribute}: #{args.first}"
    else
      super
    end
  end
end

v1 = Vendor.new
v1.find_by_email("sudha@example.com")
v1.find_by_name("Sudha")
```

* `method_missing` captures the method name and arguments.
* Useful when method names are unknown at runtime.
* Always call `super` if the method is not handled.

---

# 4. Open Classes

Ruby allows reopening and modifying existing classes—even built-in ones like `String`, `Object`, or `Kernel`.This is called **Open Class** behavior.

---

# 5. Monkey Patching

**Monkey patching** means reopening an existing class and modifying or overriding its methods.

 It is not considered good practice unless absolutely necessary, because it can affect the entire application.

### Ex :

```ruby
class String
  def upcase
    "UPCASE OVERWRITTEN"
  end

  def custom_downcase
    downcase
    puts "inside custom_downcase method"
  end
end

s1 = "Hello"
puts s1.upcase
puts s1.custom_downcase
```

---

# 6. Dynamic Method Invocation with `.send`

`.send` allows you to call a method dynamically by passing its name as a symbol or string.
It can also be used to access private methods.

### Example

```ruby
class Messenger
  def email(msg)
    "Email sent msg: #{msg}"
  end

  def sms(msg)
    "SMS sent msg : #{msg}"
  end

  def telegram(msg)
    "Telegram sent msg: #{msg}"
  end

  private
  def own
    "Hey... let me have some privacy"
  end
end

m1 = Messenger.new

method_name = :sms 
puts m1.send(method_name, "You are selected") # Calling method decided at runtime

puts m1.send(:own) # Accessing private method
puts m1.__send__(:own)  # ".__send__" is Alias for ".send"
```

* `.send(:method_name)` invokes methods dynamically.
* Useful when the method name is determined at runtime.
* Can access private methods.
* `__send__` is an alias for `send`.

---

# 7. `class_eval` and `instance_eval`

Ruby provides powerful evaluation methods to define behavior dynamically.

---

## `class_eval`

Adds instance methods to a class dynamically.

```ruby
class SampleEval
    SampleEval.class_eval do
        def demo
            "inside sample demo"
        end
    end
end

s1 = SampleEval.new
puts s1.demo
```
---
## `instance_eval`

Adds singleton methods to a specific object (including class objects).

```ruby
class SampleEval
end

SampleEval.instance_eval do
  def sam
    "inside sample sam"
  end
end

puts SampleEval.sam
```
---
# 8. Introspection

```ruby
puts m1.methods
puts m1.class
puts m1.inspect
```