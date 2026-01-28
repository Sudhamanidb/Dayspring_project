# DaySprings – Ruby & Rails Learning Notes

1️--> INSTALL RUBY
----------------
Step 1: Download and install Ruby from https://rubyinstaller.org/

Step 2: Verify installation:
   ruby -v

2️--> INSTALL RAILS
-----------------
Step 3: Install Rails gem (use CMD as Administrator):
   gem install rails
   
Step 4: Verify installation:
   rails -v

3️--> CREATE NEW RAILS PROJECT
----------------------------
Step 5: Create a folder for projects:

   cd C:\Users\Sudha
   
   mkdir rails_projects
   
   cd rails_projects
   
Step 6: Create a new Rails app:
    rails new my_first_app
   
   cd my_first_app

4️--> RUN RAILS SERVER
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


---

# Day 1 – Ruby & Rails Basics

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

---

# Day 2 – PostgreSQL, Scaffold & Console

### Project with PostgreSQL

Main database commands:

* `rails db:create` → Creates the database
* `rails db:migrate` → Applies schema changes
* `rails db:seed` → Inserts data from `seeds.rb`

* Correct order is important: **create → migrate → seed**

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

* If any value is wrong → `rails db:create` fails

### Rails Console

* `rails console` provides an interactive environment to run Rails/ActiveRecord commands.

### Mistakes Made (Day 2)

* Ran `rails db:seed` **before** `rails db:migrate`.
* Expected database changes to reflect automatically without migrations.
* Minor confusion between PostgreSQL setup and Rails configuration.

---

# Day 3 – Rails Features & File Structure

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

# Day 4 – app Folder & Ruby Basics

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
* Assumed default values are not `nil`.

---

# Day 5 – Methods, Type Casting & Product Scaffold

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

# Day 6 – Ruby Loops & Enumerable Methods

##  Ruby Loops

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

##  Enumerable Methods

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

## Key Learning (Day 6)

* Ruby offers multiple loop types for different scenarios
* Enumerable methods reduce manual looping
* Methods with `!` permanently change data
* Blocks make Ruby code clean and readable

---
**Day 7 – Ruby OOPS (Inheritance & Method Overriding)**
---
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

# Day 9 : Rails Models: Customer & Product Validations

## ---> Customer Model (`Customer < ApplicationRecord`)
---

### **Built-in Validations**

* Name is **required** and limited to 3–20 characters:

```ruby
validates :name, presence: true, length: { minimum: 3, maximum: 20 }
```

* Email is **required** and **unique**:

```ruby
validates :email, presence: true, uniqueness: true
```

### **Custom Validations**

* **Profanity check** for `name` and `email`:

```ruby
validate :deny_profanity

def deny_profanity
  profanity_words = /lopper|nonsence|idiot/i
  errors.add(:name, "is inappropriate") if name =~ profanity_words
  errors.add(:email, "is inappropriate") if email =~ profanity_words
end
```

* Check if email is present:

```ruby
def check_email
  email.present?
end
```

* Check if name contains only alphabets:

```ruby
def check_name
  name =~ /\A[a-zA-Z]+\z/
end
```

### **Usage Example (Rails Console)**

```ruby
customer = Customer.first
customer.check_email
customer.check_name
```

---

## ---> Product Model (`Product < ApplicationRecord`)

### **Built-in Validations**

* Name, description, stock, price, and is_active are validated:

```ruby
validates :name, presence: true, length: { minimum: 4, maximum: 30 }
validates :price, numericality: { greater_than_or_equal_to: 1 }
validates :stock, numericality: { greater_than_or_equal_to: 1 }, length: { maximum: 500 }
validates :description, length: { minimum: 8, maximum: 460 }, format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "only letters, numbers, and spaces allowed" }
validates :is_active, presence: true, acceptance: true, if: :price?
validates :stock, presence: true, if: :is_active?
```

### **Custom Validation**

* Ensure `is_active` is checked only if `price` and `stock` are present:

```ruby
validate :check_is_active

def check_is_active
  if is_active? && (price.blank? || stock.blank?)
    errors.add(:is_active, "cannot be checked unless price and stock are filled out")
  end
end
```

### **Helper Methods**

* **Check description validity**:

```ruby
def check_validity
  description =~ /\A[a-zA-Z0-9 ]+\z/
end
```

* **Check stock availability**:

```ruby
def check_availability
  stock > 0
end
```

**Apply discount**:

```ruby
def apply_discount(discount_percentage)
  price - (price * discount_percentage / 100)
end
```

 **Calculate total amount** (with discount and stock check):

```ruby
def total_amount
  if check_availability
    apply_discount(10).round
  else
    "Item is not available"
  end
end
```

## My_Notes with some imp points about code ...-->


1. **Built-in validations cover most use-cases**

   * Presence, uniqueness, numericality, length, format, acceptance, inclusion/exclusion.
   * Saves time and keeps code DRY.

2. **Custom validations enforce business rules**

   * For example:

     * Profanity filters (`deny_profanity`)
     * Stock-price relationships
     * Conditional validations (`is_active` only if price & stock exist)

3. **Use helper methods in models**

   * Methods like `check_availability`, `apply_discount`, `total_amount` make logic reusable and testable.

4. **Always check dependencies**

   * Example: `is_active` cannot be true unless `price` and `stock` are present.
   * Helps maintain **data integrity**.

5. **Display errors properly in views**

   * Use `@model.errors.full_messages` to show user-friendly error messages.
   * Prevents saving invalid data and improves UX.

6. **Use format validations to restrict unwanted input**

   * Avoid special characters in fields like `name` and `description`.
   * Example: `/\A[a-zA-Z0-9 ]+\z/`

7. **Conditional validations are powerful**

   * Use `if:` or `unless:` to run validations only under certain conditions.
   * Example: `validates :stock, presence: true, if: :is_active?`

8. **Never manually edit `schema.rb` or database fields**

   * Always use **migrations** to make changes.
   * Prevents schema inconsistency.

9. **Keep validation errors concise and informative**

   * Helps users understand what went wrong without confusing messages.

10. **Test validations in Rails console**

    * Always try creating invalid and valid records in the console to confirm your rules work.

---
# Day 10 – Rails Scopes
---

A **scope** is a custom query defined in a Rails model. It is mainly used when the same query is needed multiple times.
---

## Scope Examples

### 1. Out of Stock Products

Fetch products whose stock is zero or less.

```ruby
scope :out_of_stock, -> { where("stock <= ?", 0) }
#or
scope :out_of_stock, -> { where(stock: 0) }
```

---

### 2. Writing Custom / Raw SQL Query

Scopes can also contain raw SQL queries.

```ruby
scope :test_scope, -> { query {} }
```

---

### 3. Whitelisted Products

Fetch products whose IDs are in a given list.

```ruby
scope :whitelisted_products, -> { where("id IN (?)", [1, 2, 3]) }
```

---

### 4. Unique Emails

Fetch distinct email values from records.

```ruby
scope :unique_emails, -> { where(email: "sudha@gmail.com").select(:email).distinct }
```

---

### 5. Blacklisted Customers (Parameterized Scope)

Scopes can accept parameters.

```ruby
scope :blacklisted_customers, ->(customer_ids) { where(id: customer_ids) }
```

Usage:

```ruby
@customers = Customer.blacklisted_customers([3, 6, 9, 10])
```

---

## Method Chaining

Scopes can be chained together because they return ActiveRecord relations.

Example:

```ruby
Product.out_of_stock.whitelisted_products
```

---

## Controller Examples ---like how will use

### Customers Controller

```ruby
def index
  @customers = Customer.all
  # @customers = Customer.blacklisted_customers([1,2,3])
end
```

---

### Products Controller

```ruby
def index
  @products = Product.out_of_stock
end
```
---
# DAY 11 Tasks + Notes
---
## Task 1. Generating a Controller

When we run:

```
rails generate controller admin
```

Rails creates files related to **controller and views**:
This comes under **Action Pack** (Action Controller + Action View).

* `app/controllers/admin_controller.rb` → controller file
* `app/views/admin/` → folder for admin views
* `app/helpers/admin_helper.rb` → helper file
* `test/controllers/admin_controller_test.rb` → controller test file

---

## Task 2. Generating a Model

When we run:

```
rails generate model admin
```

Rails creates files related to **database and business logic**:
This comes under **Active Record**.

* `app/models/admin.rb` → model file
* `db/migrate/XXXXXXXX_create_admins.rb` → migration file
* `test/models/admin_test.rb` → model test file
* `test/fixtures/admins.yml` → test data

`rails db:migrate` is used to modify the database schema

---

## Task 3. Deleting `show.html.erb` Page

If we **delete the `show.html.erb` file** and access the show page, will get this error:

```
ActionController::UnknownFormat in CustomersController#show
CustomersController#show is missing a template for this request format.
```
Bcz -->
* `show` action exists in the controller
* But the `show.html.erb` view file is missing

---

## Task 4. Removing `def show` from Controller

If we **remove `def show` from the controller**,
there is **no error in Rails version 8**.

Bcz -->
* Rails 8 handles missing actions 
* If the route or action is not used, it does not crash the app

---
## Task 5.Changes in routes.rb

```ruby
resources :products, except: [:show]
resources :products, only: [:new, :destroy]
```
---
* `show` route is removed
* `/products/:id` is not available

###  -> If we try to open show page

URL:

```
/products/1
```

### We will get this error

```
ActionController::RoutingError
No route matches [GET] "/products/1"
```
## Bcz -->
* Rails does not have a `show` route
* Request is stopped in `routes.rb`

---
## Rails Components Table

| Name              | Feature                      | Description                                                             | Version        |
| ----------------- | ---------------------------- | ----------------------------------------------------------------------- | -------------- |
| Active Model      | Model layer support          | Provides validations, callbacks, and naming without database connection | Rails 3.0 |
| Active Record     | Object Relational Mapping    | Connects models with database tables and handles database operations    | Rails 1.0 |
| Action View       | View rendering               | Displays HTML pages using templates like ERB                            | Rails 1.0 |
| Action Controller | Request and response control | Handles browser requests, responses, and connects models with views     | Rails 1.0 |
| Active Job        | Background jobs              | Manages background tasks and job queues                                 |  Rails 4.2 |
| Active Support    | Utility helpers              | Provides Ruby extensions and helper methods                             | Rails 1.0 |
| Action Mailer     | Email sending                | Used to send emails from the application                                | Rails 1.0 |
| Action Mailbox    | Incoming email handling      | Receives and processes incoming emails                                  | Rails 6.0 |
| Action Cable      | Real-time features           | Supports WebSocket connections like chat                                | Rails 5.0 |
| Active Storage    | File uploads                 | Manages file uploads like images and documents                          | Rails 5.2 |
| Action Text       | Rich text content            | Handles rich text editor and formatted content                          | Rails 6.0 |
| Action Dispatch   | Routing and middleware       | Routes requests and manages middleware                                  | Rails 1.0 |

---

### Class Notes :
---

### Database Configuration

* `database.yml` is used for **structured data** (SQL databases)

  * Example: MySQL, PostgreSQL, SQLite
* For **unstructured data**, we use external **gems**

  * Example: MongoDB, Redis

---

### Migration: Change and Rollback

* **up method**

  * Used to add or delete columns or tables
* **down method**

  * Used to rollback changes if the up method fails

---

### Controllers and SOLID Principle

* We can create any number of controllers based on requirements
* Follow SOLID principles:

  * Thin controller
  * Flat model
  * Every class should have only one responsibility

---

### Active Job (Queueing)

* Active Job is used for background processing
* Before Rails 5, there was **no built-in queueing mechanism**
* Rails 5 and above support job queues

### Important Notes

* Not all tables need a model
* Not all models need a table
---

# Day13 - Rails Tasks and Notes

## 1. Adding a Column to a Table

To add a column to a table:

```bash
rails generate migration AddColumnColnameToTablename colname:datatype
rails generate migration AddColumnPhone_numberToCustomer phone_number:integer
rails db:migrate
```

* This will create a migration file in `db/migrate`, for example:
  `db/migrate/20260128044536_add_column_phone_to_customer.rb`

---

## 2. Installing Action Text

```bash
rails action_text:install
rails db:migrate
```

* Adds 4 tables to `schema.rb`:

  * `action_text_rich_texts`
  * `active_storage_attachments`
  * `active_storage_blobs`
  * `active_storage_variant_records`

* Creates migration files in `db/migrate`:

  * `20260128045359_create_active_storage_tables.active_storage.rb`
  * `20260128045360_create_action_text_tables.action_text.rb`

* Adds files/folders:

  * `app/assets/stylesheets/actiontext.css`
  * `app/views/active_storage/blobs/_blob.html.erb`
  * `app/views/layouts/action_text/contents/_content.html.erb`
  * `test/fixtures/action_text/rich_texts.yml`

* **Git commands:**

  * Check modified files: `git status`
  * Check changes in a specific file: `git diff <file_path>`

###  after installation

**Connections in Action Text tables**

* `active_storage_attachments` references `active_storage_blobs` via `blob_id`.
* `active_storage_variant_records` references `active_storage_blobs` via `blob_id`.

---

## 3. Array Operations in Ruby

```ruby
a1 = [1,2,3,4,5,6]
a2 = [1,3,5]

a3 = a1 & a2 # intersection => [1, 3, 5]
a4 = a1 | a2 # union => [1, 2, 3, 4, 5, 6]

print a3
puts
print a4
```

---

## 4. Debugging with `params.inspect`

* Used to inspect parameters from forms or requests for debugging.
* Stops execution and shows all permitted params in the error page.

```ruby
def create
  raise customer_params.inspect
  @customer = Customer.new(customer_params)
  respond_to do |format|
    if @customer.save
      format.html { redirect_to @customer, notice: "Customer was successfully created." }
      format.json { render :show, status: :created, location: @customer }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @customer.errors, status: :unprocessable_entity }
    end
  end
end
```

* Example output error:

```
#<ActionController::Parameters {"name"=>"jhon", "email"=>"1@gmail.com", "about_me"=>"<div>jhon is a english name</div>"} permitted: true>
```

---












