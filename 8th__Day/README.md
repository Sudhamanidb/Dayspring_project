
# Day 8 – Conditional Statements & Methods in Ruby
---
## 1. Conditional Statements

### if / else

Check a condition and run code accordingly:

```ruby
stock = 20
if stock > 0
  puts "Item available"
else
  puts "Item not available"
end
```

### Ternary Operator

Shorter version of if/else:

```ruby
is_active = true
puts is_active ? "Active" : "Not Active"
```

### elsif

Check multiple conditions in sequence:

```ruby
price = 250
if price < 200
  discount = 10
elsif price < 300
  discount = 20
else
  discount = 5
end
puts discount
```

### case / when

Cleaner way to check multiple values:

```ruby
case price
when 100..200 then discount = 10
when 201..300 then discount = 20
else discount = 5
end
puts discount
```

### unless

Runs code only if the condition is false:

```ruby
email = nil
puts "Email missing" unless email
```

---

## 2. Methods & Access Modifiers

Ruby lets you control who can use your methods:

* public → accessible anywhere
* private → can only be called inside the class
* protected → accessible in class and subclasses

Example:

```ruby
class Product
  def public_method
    puts "I am public"
  end

  private
  def private_method
    puts "I am private"
  end
end
```

