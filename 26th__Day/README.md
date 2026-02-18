# Day 26 : Object Oriented Programming 
---

## 1. Class vs Object

Class is a blueprint.
Object is the real instance created from the class.

```
class Car
end

c1 = Car.new
```

---

## 2. Instance Methods vs Class Methods

Instance methods are used when behavior depends on object data.
Class methods are used for general or utility logic.

```
class User
  def profile
    puts "Instance method"
  end

  def self.total_users
    puts "Class method"
  end
end
```

---

## 3. Modules

Module is a collection of reusable methods.
Used to avoid repetitive code.

---

## 4. include

Adds module methods to class objects.
Represents abilities or features.

```
module Walkable
  def walk
    puts "Walking"
  end
end

class Person
  include Walkable
end
```

---

## 5. Inheritance using `<`

Child class gets parent methods.
Represents IS-A relationship.

```
class Animal
  def eat
    puts "Eating"
  end
end

class Dog < Animal
end
```

---

## 6. Difference between `<` and include

`<` → identity (is a type of)
`include` → ability (has a feature)

---

## 7. initialize Method

Runs automatically when object is created.
It is inherited by child classes.

```
class Book
  def initialize(name)
    @name = name
  end
end
```

---

## 8. Diamond Problem

Ruby restricts multiple inheritance for classes to avoid confusion.
To share behavior from multiple sources, modules (mixins) are used.

---

## 9. Mixins

Mixing methods from different modules into a class.
Used to reuse functionality without inheritance.

---

## 10. Duck Typing

Ruby is dynamically typed.
It decides type based on behavior.

If an object can perform an action, it can be used.

```
def print_name(obj)
  obj.name
end
```

---

## 11. Polymorphism

Same method name behaves differently.

### Method Overriding is allowed

```
class Parent
  def speak
    puts "Parent"
  end
end

class Child < Parent
  def speak
    puts "Child"
  end
end
```

### Method Overloading is not allowed

Workaround is using default or variable arguments.

---

## 12. Polymorphic Concept in Rails

`respond_to` and `redirect_to` are examples of polymorphism because the same controller action can respond differently.

```
respond_to do |format|
  format.html
  format.json
end
```

---

## 13. respond_to

Used to return different response formats.
Rails accepts different response types such as HTML or JSON through REST requests.

---

## 14. redirect_to

Redirects to another path after an action.

```
redirect_to posts_path
```

---

## 15. Code Reusability in Rails

Repetitive Ruby logic → modules

Repetitive model and controller logic → concerns

Repetitive view logic → helpers

---

## 16. Concerns

Used to organize repeated logic feature-wise.
Multiple files can be created based on functionality.

---

## 17. Getter and Setter

Used to read and modify instance variables.

**attr_reader**
Creates only getter method (read value)

**attr_writer**
Creates only setter method (write value)

**attr_accessor**
Creates both getter and setter

```
class User
  attr_reader :name
  attr_writer :age
  attr_accessor :email
end
```
---

## 18. Background Jobs — Sidekiq

Sidekiq is a queueing server used for background jobs.
It depends on Redis, which acts as a cache and job queue.

On Windows, it is usually run using WSL with Ubuntu.

---