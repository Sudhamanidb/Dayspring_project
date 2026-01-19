Got it 👍
You want this **EXACTLY like your Day 5 notes** —
✔ clean
✔ well-commented
✔ easy to paste into **Notepad**
✔ beginner-friendly
✔ explains **what + why**

Below is your **Day 6–Style Notes** made from the code you shared.

---

📅 **Day 6 – Ruby Loops & Enumerable Methods**

---

## 🔁 Ruby Loops

### 1️⃣ `for` Loop

```ruby
arr = [2, 4, 6, 8, 10, 12]

for i in 10..15   # .. creates a range from 10 to 15 (inclusive)
  print i
  i += 1          # manual increment has no effect in for loop
end
```

📌 **Key Points**

* `for` loop **automatically increments**
* Manual `i += 1` is ignored
* `..` means inclusive range

---

### 2️⃣ `while` Loop

```ruby
puts "------------------"

i = 0   # initialization is mandatory
while i <= 10
  puts i
  i += 1   # manual increment required
end
```

📌 **Key Points**

* Condition is checked **before** execution
* If condition becomes false → loop stops
* Must initialize variable manually

---

### 3️⃣ `loop do` (Infinite Loop)

```ruby
puts "------------------"

k = 0
loop do
  puts "student : #{k}"
  k += 1
  break if k > 30   # exits loop when condition is true
end
```

📌 **Key Points**

* Runs forever unless `break` is used
* Commonly used when exit condition is inside the loop

---

### 4️⃣ `until` Loop (Opposite of `while`)

```ruby
# UNTIL → runs until condition becomes true

c = 0
until c > 15
  puts c
  c += 1
end
```

📌 **Key Points**

* `while` → runs when condition is TRUE
* `until` → runs when condition is FALSE

---

## ⏭️ `break`, `next`, `redo`

```ruby
# next → skips current iteration
# redo → repeats current iteration

loop_count = 1

for i in 1..5
  puts i

  # redo example (dangerous if not controlled)
  # redo

  loop_count += 1
  break if loop_count > 6
end
```

📌 **Key Points**

* `next` → skip iteration
* `redo` → repeat same iteration (can cause infinite loop)
* `break` → exit loop completely

---

## 🔂 Enumerable Methods (`each`, `select`, `reject`, `map`)

### Array Used

```ruby
arr = [2, 4, 6, 8, 10, 12]
```

---

### 1️⃣ `select`

```ruby
print arr
puts

print arr.select { |num| num > 4 }
puts
```

📌 **What it does**

* Returns values where condition is **true**
* Does NOT modify original array

---

### 2️⃣ `select!` (Destructive)

```ruby
res = arr.select! { |num| num > 4 }
puts res
```

📌 **Important**

* `!` means **destructive**
* Original array is modified

---

### 3️⃣ `reject` & `reject!`

```ruby
res1 = arr.reject! { |num| num > 2 }
puts res1

print arr
```

📌 **Difference**

* `reject` → removes values where condition is true
* `reject!` → modifies original array

---

### ⚠️ Difference Summary

```text
select      → returns matching values (non-destructive)
select!     → keeps matching values (destructive)
reject      → returns non-matching values
reject!     → removes matching values (destructive)
```

---

## ✅ `any?` and `all?`

```ruby
arr2 = [1, 2, 3, 4, 5]

arr2.any? { |num| num > 5 }   # false
arr2.all? { |num| num > 0 }   # true
```

📌 **Meaning**

* `any?` → at least one true
* `all?` → all must be true

---

## 🔄 `map`, `collect`, `each`

```ruby
arr3 = arr2.map { |num| num ** 2 }
print arr3
puts

arr4 = arr2.collect { |num| num ** 2 }
print arr4
puts

arr5 = arr2.each { |num| num ** 2 }
print arr5
puts
```

📌 **Key Differences**

```text
map / collect → returns new array
each          → returns original array
```

---

## 🧠 Key Learning (Day 6)

* `for` loop auto-increments
* `while` & `until` need manual control
* `loop do` requires explicit `break`
* `!` methods permanently change data
* Ruby blocks use `{}` or `do..end`
* Enumerable methods make code clean & readable

---

If you want, I can also:

* 🔹 Convert this into **PDF / Notes format**
* 🔹 Add **simple interview questions**
* 🔹 Continue with **Day 7 – Hashes & Blocks**

Just tell me 👍

