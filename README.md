** 📅 DAY 1**

1️⃣ INSTALL RUBY
----------------
Step 1: Download and install Ruby from https://rubyinstaller.org/

Step 2: Verify installation:
   ruby -v

2️⃣ INSTALL RAILS
-----------------
Step 3: Install Rails gem (use CMD as Administrator):
   gem install rails
   
Step 4: Verify installation:
   rails -v

3️⃣ CREATE NEW RAILS PROJECT
----------------------------
Step 5: Create a folder for projects:

   cd C:\Users\Sudha
   
   mkdir rails_projects
   
   cd rails_projects
   
Step 6: Create a new Rails app:
    rails new my_first_app
   
   cd my_first_app

4️⃣ RUN RAILS SERVER
--------------------
Step 7: Start server:
   rails server
   
Step 8: Open browser and go to:
   http://localhost:3000
(Optional) 
   Change port:
   rails server -p YOUR_PORT_NUMBER
   
   Stop server:
   Ctrl + C


# DaySprings – Ruby & Rails Learning Notes

---

## Day 1 – Ruby & Rails Basics

### Ruby

* Ruby is a **dynamically typed**, **open-source** programming language known for **simplicity** and **developer productivity**.
* Everything in Ruby is an **object**.
* Latest stable version: **Ruby 3.x**.
* Ruby generally follows **SOLID principles** (with limited emphasis on Interface Segregation due to Ruby’s dynamic nature).

### Rails

* Rails is a **web application framework built on Ruby**.
* It helps developers build applications faster by providing conventions and boilerplate code.
* Latest major version: **Rails 8.x**.

### Important Points

* Ruby version management is done using **RVM** or **RBENV** (used to switch Ruby versions).
* Install Rails using:

  ```bash
  gem install rails
  ```
* Ruby alone can create applications, but frameworks like Rails:

  * Reduce development time
  * Provide structure
  * Generate boilerplate code automatically

### Creating a Rails Project

Rails projects can be created in multiple ways:

1. `rails new project_name`
2. `rails new project_name --api` (API-only / two-tier architecture)
3. **Scaffold** (auto-creates MVC components)

### Commands to Remember

* `ruby --version`
* `rails --version`
* `gem install rails`
* `rails new ProjectName`

### Mistakes Made (Day 1)

* Confused **Ruby** with **Rails** (thinking both are the same).
* Assumed Rails is mandatory to write Ruby programs.
* Minor spelling mistakes in commands (`gem insatll rails`).

---

## 📅 Day 2 – PostgreSQL, Scaffold & Console

### Project with PostgreSQL

Main database commands:

* `rails db:create` → Creates the database
* `rails db:migrate` → Applies schema changes
* `rails db:seed` → Inserts data from `seeds.rb`

⚠️ Correct order is important: **create → migrate → seed**

### Scaffold

* Scaffold generates the **complete skeleton** of an application:

  * Model
  * Controller
  * Views
  * Routes

Command:

```bash
rails generate scaffold Customer name:string email:string
```

Controller-only generation:

```bash
rails generate controller Customers
```

### Project Creation Commands

* `rails new project_name`
* `rails new project_name -d postgresql`
* `rails new project_name -d postgresql --skip-test`

### database.yml

* Configuration file for database connection
* Contains:

  * host
  * username
  * password
  * database name

⚠️ If any value is wrong → `rails db:create` fails

### Rails Console

* `rails console` provides an interactive environment to run Rails/ActiveRecord commands.

### Mistakes Made (Day 2)

* Ran `rails db:seed` **before** `rails db:migrate`.
* Expected database changes to reflect automatically without migrations.
* Minor confusion between PostgreSQL setup and Rails configuration.

---

## 📅 Day 3 – Rails Features & File Structure

### Main Features

#### Syntactic Sugar

* Rails auto-generates MVC components without writing everything manually.

#### Convention Over Configuration

* Rails uses naming conventions to auto-configure behavior.

Example:

```bash
rails generate model Customer
```

Naming Rules:

* **Model** → Singular (`Customer`)
* **Controller** → Plural (`CustomersController`)

### Config Folder

Controls how the Rails application behaves.

Important files:

* `config/database.yml` → Database configuration
* `config/routes.rb` → Maps URLs to controllers
* `config/application.rb` → Main app configuration
* `config/environment.rb` → App entry point
* `config/environments/` → environment-specific settings

### DB Folder

Handles database-related tasks.

Important files:

* `db/migrate/` → Migration files
* `db/schema.rb` → Current DB structure (auto-generated)
* `db/seeds.rb` → Initial/sample data

### Mistakes Made (Day 3)

* Confused **model naming rules** (plural vs singular).
* Tried to edit `schema.rb` manually.

---

## 📅 Day 4 – app Folder & Ruby Basics

### app Folder

Main application code lives here.

* **controllers** → Handle requests & responses
* **views** → UI files (`.html.erb`)
* **models** → Database logic
* **javascript** → Frontend behavior (Rails 8 integration)
* **mailers** → Sending emails
* **jobs** → Background tasks

**Best Practice:**

* Thin Controllers
* Thick Models

### Ruby Data Types

* String (mutable)
* Integer
* Float
* Symbol (immutable)
* Boolean
* nil

All data types are objects.

### Variables

* Local → `name`
* Global → `$name`
* Instance → `@name`
* Class → `@@name`
* Constant → `NAME`

### Mistakes Made (Day 4)

* Confusion between **Symbol** and **String**.
* Assumed default values are not `nil`.

---

## 📅Day 5 – Methods, Type Casting & Product Scaffold

### Methods & Comments

* Ruby methods return the **last evaluated expression automatically**.
* `return` is optional.

Comments:

* Single-line → `#`
* Multi-line → `=begin` / `=end`

### Type Casting

* User input is always a **String**.
* Ruby does **not** do implicit type casting.

Examples:

* `"10".to_i`
* `10.to_s`
* `"10.5".to_f`

### Product Scaffold

Command:

```bash
rails generate scaffold Product name:string description:text price:decimal stock:integer is_active:boolean
```

After any DB-related change:

```bash
rails db:migrate
```

### Ways to Insert Data

1. **UI** (Rails-generated forms)
2. **Manual SQL (DBeaver)**
3. **Seeds file (`db/seeds.rb`)**
4. **Rails Console**

Example SQL:

```sql
INSERT INTO products (name, description, price, stock, is_active, created_at, updated_at)
VALUES ('IQ', 'The IQ new product', 80, 2, TRUE, '2026-01-16', '2026-01-16');
```

Example seed:

```ruby
Product.create(name: "Tesla 1", description: "The tesla 1 product", price: 900, stock: 30, is_active: true)
```

### Mistakes Made (Day 5 – Important)

* Gave **space in column names** while writing Rails queries.
* Used wrong case in model name (must start with **capital letter**).
* Forgot timestamps (`created_at`, `updated_at`) while inserting via SQL.
* Misspelled column names (`stack` instead of `stock`).
* Forgot to run `rails db:migrate` after scaffold.

---

## Key Learning from Mistakes

* Rails is **convention-driven** → names & order matter.
* YAML files are **very strict** (indentation & duplication break Rails).
* Database changes require **migrations + code updates**.
* Warnings (like VIPS) are different from actual errors.


---

📅 **Day 6 – Ruby Loops & Enumerable Methods**

## 🔁 Ruby Loops

### `for` Loop

Used when the range or count is known.

```ruby
arr = [2, 4, 6, 8, 10, 12]

for i in 10..15   # inclusive range
  print i
end
```

Key Points:

* Automatically increments
* Manual increment does not work
* `..` includes both start and end values

---

### `while` Loop

Executes while the condition is true.

```ruby
i = 0
while i <= 10
  puts i
  i += 1
end
```

Key Points:

* Condition checked before execution
* Manual initialization and increment required

---

### `loop do`

Infinite loop with explicit exit condition.

```ruby
k = 0
loop do
  puts "student : #{k}"
  k += 1
  break if k > 30
end
```

Key Points:

* Runs continuously
* `break` is mandatory to stop

---

### `until` Loop

Opposite of `while`.

```ruby
c = 0
until c > 15
  puts c
  c += 1
end
```

Key Points:

* Runs while condition is false

---

### Loop Control Keywords

```text
break → exits the loop
next  → skips current iteration
redo  → repeats current iteration
```

---

## 🔂 Enumerable Methods

### Array Used

```ruby
arr = [2, 4, 6, 8, 10, 12]
```

---

### `select` and `select!`

```ruby
arr.select { |num| num > 4 }
arr.select! { |num| num > 4 }
```

Key Difference:

* `select` returns filtered values
* `select!` modifies the original array

---

### `reject` and `reject!`

```ruby
arr.reject { |num| num > 2 }
arr.reject! { |num| num > 2 }
```

Key Difference:

* `reject` keeps original array unchanged
* `reject!` permanently modifies it

---

### Destructive vs Non-Destructive Summary

```text
select   → non-destructive
select!  → destructive
reject   → non-destructive
reject!  → destructive
```

---

### `any?` and `all?`

```ruby
arr2 = [1, 2, 3, 4, 5]

arr2.any? { |num| num > 5 }
arr2.all? { |num| num > 0 }
```

Meaning:

* `any?` → at least one condition is true
* `all?` → all conditions are true

---

### `map`, `collect`, `each`

```ruby
arr2.map { |num| num ** 2 }
arr2.collect { |num| num ** 2 }
arr2.each { |num| num ** 2 }
```

Key Difference:

* `map` and `collect` return a new array
* `each` returns the original array

---

## 🧠 Key Learning (Day 6)

* Ruby offers multiple loop types for different scenarios
* Enumerable methods reduce manual looping
* Methods with `!` permanently change data
* Blocks make Ruby code clean and readable


##📅 Day 7 – Ruby OOP (Inheritance & Method Overriding)

### Classes & Objects

* A class is a blueprint for creating objects.
* An object is an instance of a class.
* Methods define the behavior of an object.
* Instance variables (`@variable`) store object-specific data.

---

### Inheritance

* Inheritance allows one class to reuse another class’s methods and variables.
* Child classes inherit behavior from parent classes using `<`.
* Helps reduce code duplication.
* Parent instance variables are accessible in child classes.

---

### Method Overriding

* Child class can redefine a method from the parent class.
* Ruby always calls the child method first if names match.
* Overriding is used to change or extend existing behavior.

---

### `super` Keyword

* `super` calls the parent class method.
* Can be used with or without arguments.
* Helps extend parent functionality instead of replacing it.

---

### Method Lookup

* Ruby searches for methods in this order:

  1. Current class
  2. Parent class
  3. Modules
  4. Object
* `ancestors` shows the method lookup chain.

---

### Built-in Reflection Methods

* `respond_to?` checks if an object can respond to a method.
* Useful for safer method calls and debugging.

---

### Method Overriding Example (Concept)

* Same method name in parent and child.
* Parent logic can be reused using `super`.
* Child method changes output or behavior.

---


