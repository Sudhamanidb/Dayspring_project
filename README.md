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

# Day 14: Active Storage

## 1. Installation

Active Storage is included in Rails 5.2+. If not installed:

```bash
rails active_storage:install
rails db:migrate
```

> Configure storage in `config/storage.yml` for local or cloud (AWS, GCP, etc.).

---

## 2. Attaching Files to Models

**Product model (single & multiple attachments, rich text):**

```ruby
class Product < ApplicationRecord
  has_one_attached :invoice
  has_many_attached :product_images
  has_rich_text :review
end
```

**Customer model (multiple attachments):**

```ruby
class Customer < ApplicationRecord
  has_many_attached :profile_photos
end
```

> Use **snake_case** for attachment names.

---

## 3. Strong Parameters

**Product controller:**

```ruby
def product_params
  params.require(:product).permit(:name, :description, :price, :stock, :is_active, :review, :invoice, product_images: [])
end
```

**Customer controller:**

```ruby
def customer_params
  params.require(:customer).permit(:name, :email, :phone_number, :about_me, profile_photos: [])
end
```

---

## 4. Forms in Views

**Product form:**

```erb
<%= form.rich_text_area :review, class: "form-control", placeholder: "Enter review" %>
<%= form.file_field :product_picture, class: "form-control", multiple: true %>
<%= form.file_field :invoice, class: "form-control" %>
```

**Customer form:**

```erb
<%= form.file_field :profile_photos, class: "form-control", multiple: true %>
```
---

## 5. Adding Columns via Migration

```bash
rails generate migration AddColumnDobToCustomer dob:date
rails db:migrate
```

> Adds a `dob` column to `customers`.

---

## 6. Displaying Attachments

```erb
<% if customer.profile_photos.attached? %>
  <% customer.profile_photos.each do |photo| %>
    <%= image_tag url_for(photo), class: "rounded" %>
  <% end %>
<% end %>

<% if product.invoice.attached? %>
  <%= link_to "Download Invoice", url_for(product.invoice) %>
<% end %>
```

---
## 7. Key Points

1. Use **snake_case** for attachment names.
2. **Action Text** requires Active Storage.
3. Configure cloud storage in `storage.yml`.
4. For multiple files: `has_many_attached` + `multiple: true`.
5. Always whitelist attachments in controllers.
6. Use `url_for` to render attachments in views.

---
# Day 15 – Action Mailer

Action Mailer is used to **send emails** in Rails applications.
We **do not need to install** Action Mailer separately. It is **included by default** when a Rails application is created.

---

## Step 1: Generate Mailer

```bash
rails generate mailer CustomerMailer
```

This command creates the following files:

* `app/mailers/customer_mailer.rb`
* `app/views/customer_mailer/`
* `test/mailers/customer_mailer_test.rb`
* `test/mailers/previews/customer_mailer_preview.rb`

---

## Step 2: application.rb Changes

```ruby
require "action_mailer/railtie"
```

This file loads Action Mailer functionality. In most Rails apps, it is already included via `rails/all`.

---

## Step 3: Configure Email Delivery (development.rb)

Edit `config/environments/development.rb`:

```ruby
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :letter_opener
```

* `letter_opener` is used to **mock email sending** in development
* Emails will open in browser instead of being sent
* In production, delivery method is usually **SMTP**

---

## Step 4: Customer Mailer Method

`app/mailers/customer_mailer.rb`

```ruby
class CustomerMailer < ApplicationMailer
  def welcome_email
    @customer = params[:customer]
    mail(to: @customer.email, subject: "Welcome !!")
  end
end
```

`params` contains all the data passed while calling the mailer.

---

## Step 5: Mailer View

Create the file:

```
app/views/customer_mailer/welcome_email.html.erb
```

Add HTML content for the email.
---

## Step 6: Trigger Email from Controller

Send mail **after saving data**:

```ruby
CustomerMailer.with(customer: @customer).welcome_email.deliver
```

This line triggers the email.

---

## Step 7: Add Gems

In `Gemfile`:

```ruby
gem "letter_opener", group: :development
gem "letter_opener_web", group: :development
```

Run:

```bash
bundle install
```

---

## Step 8: Configure Routes

`config/routes.rb`

```ruby
if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
```

Visit in browser:

```
http://localhost:3000/letter_opener
```

---

## Product Mailer Example

Generate mailer:

```bash
rails generate mailer ProductMailer
```

Files created:

* `app/mailers/product_mailer.rb`
* `app/views/product_mailer/`
* `test/mailers/previews/product_mailer_preview.rb`
* `test/mailers/product_mailer_test.rb`

### Product Mailer Code

```ruby
class ProductMailer < ApplicationMailer
  def welcome_email
    @product = params[:product]
    mail(to: @product.email, subject: "Welcome to Rails Mailer Concept")
  end
end
```

---

## Calling Mailer from Controller

```ruby
def create
  @product = Product.new(product_params)

  if @product.save
    ProductMailer.with(product: @product).welcome_email.deliver
    redirect_to @product, notice: "Product was successfully created."
  else
    render :new, status: :unprocessable_entity
  end
end
```

---

## Mailer View for Product

Create:

```
app/views/product_mailer/welcome_email.html.erb
```

 Method name and view name must match:

```
welcome_email → welcome_email.html.erb
```

---

## Key Points 

* Action Mailer is built into Rails
* Do not delete `application.rb` or `boot.rb`
* `letter_opener` is used for development email preview
* Mailer method name must match view file name
* Emails should be triggered **after saving data**
* `params` contains all passed request data

---

# Day 16 – Action Mailbox 
---

## 1. Install Action Mailbox
```bash
rails action_mailbox:install
```

**Generated files:**

* `app/mailboxes/application_mailbox.rb`
* `db/migrate/20260202042002_create_action_mailbox_tables.action_mailbox.rb`

---

## 2. Database Migration
```bash
rails db:migrate
```

**Table created:**

* `action_mailbox_inbound_emails`

Used to store all incoming emails.

---
## 3. Production Configuration

In `config/environments/production.rb`:

```ruby
config.action_mailbox.ingress = :any_ingress_server
```

> Default ingress is `:relay`.

---
## 4. Application Mailbox

```ruby
class ApplicationMailbox < ActionMailbox::Base
  routing all: :support
end
```

All incoming emails are routed to `SupportMailbox`.

---
## 5. Generate Support Mailbox

```bash
rails generate mailbox support
```

**Generated files:**

* `app/mailboxes/support_mailbox.rb`
* `test/mailboxes/support_mailbox_test.rb`

---

## 6. Support Mailbox Logic

```ruby
class SupportMailbox < ApplicationMailbox
  def process
    # mail.decode  -> email body
    # mail.from    -> sender
    # mail.subject -> subject
  end
end
```

`process` method handles incoming email data.

---

## 7. View Incoming Emails (Development)

```bash
rails s
```
Open:

```
http://127.0.0.1:3000/rails/conductor/action_mailbox/inbound_emails
```

will get:
* View inbound emails
* Create emails using form or source
* Check message ID and status
---


# Day 17 – References and Methods

---

## **1. Creating a Namespaced Model (Model under another Model)**

Command to generate a namespaced migration:

```bash
rails generate migration ParentModel::ChildModel
```

**Example:**

```bash
rails generate migration Product::Category
rails db:migrate
```

This creates a **Category model inside Product namespace**.

---

## **2. Adding Column to a Namespaced Model**

General command:

```bash
rails generate migration AddColumnToModelName column_name:datatype
```

**Example:**

```bash
rails generate migration AddColumnCategoryNameToProductCategory category_name:string
rails db:migrate
```

This adds a `category_name` column to `Product::Category`.

---

## **3. ActiveRecord Methods**

### **Insert Records**
```ruby
ModelName.insert({ column: value, column: value })
ModelName.insert({})
ModelName.insert_all([{},{},{},...])
```

---

### **Find Records**
```ruby
Model.find(id)
```

* Returns record if present
* Throws exception if not found

```ruby
Model.find_by(id: id)
```

* Returns record if present
* Returns `nil` if not found

---

### **Fetch Records by Order**
```ruby
Model.first
Model.second
Model.third
Model.fourth
Model.fifth
Model.last
```

---

## **References**
* **Reference**: stores another table’s id to connect records
* **has_many**: one record is linked to many records
* **foreign_key**: tells Rails which column connects tables
* **Reference during generation**: creates DB column + relation together

---

## **Primary Key**
* **primary key**: unique column used to identify a record
* **custom primary key**: used when column name is not `id`

---

## **Migration Handling**
* **Migration not run**: delete the file
* **Migration run**: fix using a new migration

---

## **SQL vs Rails**
* **SQL**: direct database query
* **ActiveRecord**: Ruby way to write database queries

---

## **Fetching Records**
* **all.limit(n)**: returns first `n` records
* **take**: returns one random record

---

## **Method Differences**
* **save**: saves object with validations
* **find**: finds record by id only (error if not found)
* **find_by**: finds record by any column (nil if not found)
* **where**: returns filtered records as a collection → `[]`
* **delete**: removes record without callbacks
* **destroy**: removes record with callbacks (safe)
* **update**: updates record with validations
* **update_all**: updates many records without validations (fast but risky)

---

---

# Day 18 – Core Extensions & ActiveSupport
---

## **1. Core Extensions**
Rails extends Ruby core classes using **ActiveSupport**.

### Covered Extensions

* **Date calculation methods**
* **Time calculation methods**
* **String methods**
* **Array methods**
* **Hash methods**
* **Object methods**

These methods are **available only in Rails**, not in plain Ruby.

---

## **2. ActiveSupport Methods**

ActiveSupport adds helper methods that make Rails development easier.
Example:
```ruby
Time.zone.now
```
Console output:
```
2026-02-04 05:40:23.064766300 UTC +00:00
```
---

## **3. Time Calculations**

Rails allows time calculations using readable syntax.
### Example:
```ruby
curr = Time.zone.now
```
#### Adding Time

```ruby
curr + 2.day
curr + 3.week
curr + 3.month
curr + 2.days
curr + 2.hour
```
#### Output Examples:
* `curr + 2.day` → adds 2 days
* `curr + 3.week` → adds 3 weeks
* `curr + 3.month` → adds 3 months
* `curr + 2.hour` → adds 2 hours

### Supported Time Helpers
* `n.day / n.days`
* `n.hour / n.hours`
* `n.week / n.weeks`
* `n.month / n.months`

---
## **4. Date Methods**
```ruby
Date.today
Date.new(year, month, day)
```
### Beginning of Period
```ruby
Date.today.beginning_of_day
Date.today.beginning_of_week
Date.today.beginning_of_month
Date.today.beginning_of_year
```
### End of Period
```ruby
Date.today.end_of_day
Date.today.end_of_week
Date.today.end_of_month
Date.today.end_of_year
```
---
## **5. Instrumentation (Pub/Sub)**
* Used for **logging and monitoring**
* Rails uses **publish–subscribe** mechanism internally
* Helps track events like requests, SQL queries, etc.
---

## **6. ActiveSupport::Concern**
* Used to **share common code between models/controllers**
* Helps organize reusable modules
* Keeps code clean and structured
---

## **7. Multi-Language Translations (I18n)**

* Rails uses **I18n** for language translations
* Translations are configured using `en.yml`
Example:
```yaml
en:
  hello: "Hello"
```
* `I18n` is the class that holds all translations
---

## **8. Blank, Nil, Present, Empty Methods**

These methods are provided by **ActiveSupport**.
### `blank?`
```ruby
" ".blank?   # true
[].blank?    # true
{}.blank?    # true
```
---

### `nil?`
```ruby
" ".nil?   # false
[].nil?    # false
{}.nil?    # false
```
--
### `present?`
```ruby
" ".present?   # false
[].present?    # false
{}.present?    # false
```
---
### `empty?`
```ruby
" ".empty?   # true
[].empty?    # true
{}.empty?    # true
```
---

## **9. N+1 Query Problem**

The **N+1 Query Problem** happens when:

* One query loads parent records
* Separate queries are executed for each associated child record

This usually occurs due to **lazy loading** in Rails.

---
## Not good 

```ruby
User.all.each do |user|
  puts user.orders.count
end
```

 Runs **1 query for users + N queries for orders**
---

## Solution is Eager Loading 

```ruby
User.includes(:orders).each do |user|
  puts user.orders.count
end
```
 Loads users and orders in advance using **minimum queries**

* N+1 slows down performance
* Use `includes` to avoid extra queries
* Always check logs for N+1 issues
---


# Day 19 – References and Associations 
---

## Associations in Rails

Associations define how **models (tables)** are related in a Rails application.
They help ActiveRecord fetch related data easily without writing SQL.

---

### Relationship Types

* **One-to-One**: One record is linked to one record
  *Example:* User → Profile

* **One-to-Many**: One record has many records
  *Example:* User → Orders

* **Many-to-One**: Many records belong to one record
  *Example:* Orders → User (`belongs_to`)

* **Many-to-Many**: Many records are linked to many records
  *Example:* Students ↔ Courses

---

### Rails Association Ways

`has_one`, `has_many`, `belongs_to`, `has_one :through`, `has_many :through`, `polymorphic`

---
### Polymorphic Association

A polymorphic association allows **one model to belong to multiple models**, where a single table acts as a child for different parent tables.
---

## **1. Generate Model with Reference**

```bash
rails generate model Vendor name:string location:string user:references
```
### Generated Files
```
app/models/vendor.rb
db/migrate/XXXXXXXXXX_create_vendors.rb
test/models/vendor_test.rb
test/fixtures/vendors.yml
```
---
## **2. Migration File Content (auto-generated)**

```ruby
create_table :vendors do |t|
  t.string :name
  t.string :location
  t.references :user, null: false, foreign_key: true
  t.timestamps
end
```
---
## **3. Run Migration**

```bash
rails db:migrate
```

### Effect

```
Creates vendors table in database
Adds user_id foreign key
```
---
## **4. Generate Model (Without Reference)**
```bash
rails generate model Order details:string count:integer
```
### Generated Files
```
app/models/order.rb
db/migrate/XXXXXXXXXX_create_orders.rb
test/models/order_test.rb
test/fixtures/orders.yml
```

---
## **5. Add Reference to Existing Model**

```bash
rails generate migration AddUserToOrders user:references
```
### Generated Files
```
db/migrate/XXXXXXXXXX_add_user_to_orders.rb
```

---
## **6. Add Column to Existing Table**

```bash
rails generate migration AddEmailToVendors email:string
```
### Generated Files
```
db/migrate/XXXXXXXXXX_add_email_to_vendors.rb
```
---
## **8. Create Records from Console**

```ruby
User.create(name: "Sudha")
Vendor.create(name: "Radha", location: "Varanasi", user_id: 1)
Order.create(details: "Krishna", count: 2, user_id: 1)
```

---
## **9. Association-Based Creation**

```ruby
User.last.vendors.create(name: "Sudha", location: "Mandya")
Product.last.orders.create(details: "Wanted Books", count: 5)
```
---
* `rails generate model` → model + migration + tests
* `rails generate migration` → only migration file
* `user:references` → creates `user_id` + foreign key
* `rails db:migrate` → applies changes to DB

---

# Tasks – Associations & Foreign Keys

## Task 1: Create Tables with Relationship and Verify Associations

In this task, we created **two tables with a relationship** and verified the association at both **SQL level** and **Rails level**.

#### Steps Covered:

* Created two tables with a foreign key relationship
* Verified **foreign key constraints at SQL (database) level**
* Checked behavior **before adding Rails associations**
* Added Rails-level associations (`has_many`, `belongs_to`)
* Verified behavior **after adding Rails associations**

#### Observation:

* At **SQL level**, foreign key ensures data integrity
* At **Rails level**, associations make data access easier and readable

---

## Task 2: Add Relationship to Existing Tables with Records

In this task, we tried to create a relationship between **already existing tables that contain data**.

#### Issue Faced:

* Migration failed due to existing records
* Foreign key constraint caused an error

#### Solution:

* Handled the error by providing a **default value** or allowing null values
* Successfully applied the relationship without data loss

---
* SQL-level association → ensures data consistency
* Rails-level association → improves developer experience
* Existing data needs special handling while adding relationships

---


# Day 20. Many-to-Many Association using HABTM (Product & Tag)

This implementation demonstrates a **many-to-many relationship** between **Product** and **Tag** using **`has_and_belongs_to_many (HABTM)`** in Rails.

---
## 1. Tag Creation

The `Tag` model was generated to store tag-related data.
```bash
rails g model Tag name:string desc:string
rails db:migrate
```

**Table created:**
```
tags
----
id | name | desc
```
This table stores **only tag information**.

---

## 2. Join Table Creation
To connect products and tags, a **join table** was created.
```bash
rails generate migration CreateJoinTableProductsTags products tags
```

Migration:
```ruby
def change
  create_join_table :products, :tags do |t|
    t.index [:product_id, :tag_id]
    t.index [:tag_id, :product_id]
  end
end
```

**Table created:**
```
products_tags
--------------
product_id | tag_id
```
* This table has **no model**
* Stores **only IDs**
* Exists **only to connect Product and Tag**

---
## 3. Model Associations

Associations were added to both models.
```ruby
class Product < ApplicationRecord
  has_and_belongs_to_many :tags
end
```

```ruby
class Tag < ApplicationRecord
  has_and_belongs_to_many :products
end
```

Rails now automatically manages the relationship using the `products_tags` table.
---

## 4. Inserting Data into Join Table (Auto Insert)

Existing records were linked using Rails association methods.

```ruby
prod3 = Product.second
prod3.tags << Tag.last
```

What happens internally:

* Rails **automatically inserts** a row into `products_tags`
* No manual insert is required

```
product_id | tag_id
2          | 5
```
This shows that **Product 2 is linked to Tag 5**.
---

## 5. Fetching Associated Data

To retrieve tag names for a product:

```ruby
prod3.tags.map(&:name)
or
prod3.tags.pluck(:name)
```
---
## Main Difference 

**HABTM uses the third table only to connect records, while `has_many :through` uses the third table to store data about the relationship.**

---

| HABTM                   | has_many :through            |
| ----------------------- | ---------------------------- |
| Just connection         | Connection + details         |
| Join table has only IDs | Join table has extra columns |
| No join model           | Join model exists            |
| Auto insert by Rails    | Manual / controlled insert   |

---

* `products` and `tags` are independent tables
* `products_tags` is a simple join table
* The join table **only links records**
* Rails handles inserts automatically

---

## Additional Notes 

### When do we need a third table?

* **One-to-One** → no third table
* **One-to-Many** → no third table
* **Many-to-One** → handled using `belongs_to`
* **Many-to-Many** → third table is required

For many-to-many:
* **HABTM** → only for linking records
* **has_many :through** → used when the relation has extra data

---

### `has_many :through`

* Always uses a **join model**
* The join model always has `belongs_to`

```ruby
class ProductTag < ApplicationRecord
  belongs_to :product
  belongs_to :tag
end
```

---

### Naming matters in Rails

* Table names → plural
* Model names → singular
* Join tables → alphabetical order
If naming is wrong, associations won’t work properly.

---

### Table name and model name should match

* `products` table → `Product` model
* `tags` table → `Tag` model

Rails expects this to auto-generate queries.
---

### `has_many` should always be plural

```ruby
has_many :tags   # correct
has_many :tag    # wrong
```
Because one record can be linked to many records.

---

### `dependent: :destroy`

Deletes associated records automatically when the parent record is deleted.

```ruby
class User < ApplicationRecord
  has_many :orders, dependent: :destroy
end
```
```ruby
u1 = User.find(5)
u1.destroy
```
* User is deleted
* Related orders are deleted

**Note:**
Add `dependent: :destroy` **only on the parent**, not on both sides.

---
## Task
---
This command is **not correct**:
```bash
rails generate migration CreateJoinsTableProductsTags products tags
```

What happens if you run it:

* Rails will create a migration file
* But it won’t generate a join table automatically
* There is no method called `create_joins_table`
* If you try to use it, Rails will raise an error

Why this happens:

* Rails only recognizes **`join`** for join table creation
* **`joins`** is meant for querying data, not for migrations
Use **join** when creating tables, and **joins** when fetching records.

Correct way to do it:

```bash
rails generate migration CreateJoinTableProductsTags products tags
```
# Day 22 – Rails Migrations, Rollback and `has_many :through`

## 1. Database Rollback

Rollback is used to undo database migrations.

### Commands

```bash
rails db:rollback
```
Rolls back the most recent migration.

```bash
rails db:rollback STEP=2
```
Rolls back the last two migrations.

---

## 2. Schema Changes After Migrations

* After every migration command, the `schema.rb` file is updated automatically.
* The timestamp (for example `2026_02_06_062922`) represents the latest migration state.
* The schema file always reflects the current database structure.

---

## 3. Manual Migration Changes

When modifying an existing column, such as changing a datatype, use `up` and `down` methods instead of `change`.

### Reason

* The `change` method cannot always be reversed automatically.
* `up` defines how the migration is applied.
* `down` defines how the migration is rolled back.

---

## 4. Destroying a Model

```bash
rails destroy model ProductsOffer
```

This command removes:
* The migration file
* The model file
* Test files
* Fixture files

It ensures a clean removal of all generated files related to the model.

---

## 5. `has_many :through` Association

### Generating the Subscription Model

```bash
rails generate model Subscription type:string validity:date active:boolean product:references offer:references
```

### Generated Files
* db/migrate/XXXXXXXX_create_subscriptions.rb
* app/models/subscription.rb
* test/models/subscription_test.rb
* test/fixtures/subscriptions.yml

---

### Model Associations

#### Product Model
```ruby
has_many :subscriptions
has_many :offers, through: :subscriptions
```

#### Offer Model
```ruby
has_many :subscriptions
has_many :products, through: :subscriptions
```

#### Subscription Model
```ruby
belongs_to :product
belongs_to :offer
```

---

## 6. Rails Console Operations

```ruby
productObj = Product.find(5)
offerObj   = Offer.find(2)
productObj.offers << offerObj
```

### Fetching Offers
```ruby
p1 = Product.last
p1.offers
```

### Reloading Data
```ruby
p1.offers.reload
```
Reloads the query from the database.
---

### Common Helper Methods
```ruby
p1.offers.empty?
p1.offer_ids
p1.offers.size
p1.offers.exists?(id: 2)
```

---

### Finding Specific Offers
```ruby
p1.offers.find_by(id: 2)
p1.offers.find_by(off_name: "Unbelievable sale")
```
---

### Creating and Deleting Offers
```ruby
productObj.offers.create(attributes)
productObj.offers.delete(offerObj)
```

---

## 7. Updating Extra Columns in Join Table

### Updating a Single Subscription
```ruby
subscriptionObj.update(
  status: 'active',
  renewal_date: 1.month.from_now
)
```
---

### Updating a Specific Subscription for a Product
```ruby
productObj.subscriptions
          .where(offer_id: 5)
          .update_all(status: 'active')
```
---

### Updating All Subscriptions Based on Condition

```ruby
productObj.subscriptions.each do |sub|
  sub.update(status: 'expired') if sub.end_date < Date.today
end
```
---

## 8. Adding Reference Using Migration

```bash
rails generate migration AddCustomerReferenceToOrders customer:references
```
### Migration File
```ruby
def change
  add_reference :orders, :customer, foreign_key: true, index: { unique: true }
end
```
---

### Model Associations

#### Order Model
```ruby
has_one :customer
```
#### Customer Model
```ruby
belongs_to :order
```
---
# Day 23 – Migrations & Associations

---

## 1. Migration Naming Convention

Rails follows:

**Verb + Column/Table + TargetTable**

Examples:

| Purpose       | Migration Name              |
| ------------- | --------------------------- |
| Create table  | CreateUsers                 |
| Add column    | AddEmailToUsers             |
| Remove column | RemovePhoneFromUsers        |
| Add reference | AddUserToBlogs              |
| Rename table  | RenameCommentsToDiscussions |
| Change column | ChangeDescriptionInBlogs    |

Notes:

* Table names → plural
* Model names → singular
* Proper naming allows Rails to auto-generate `def change` correctly
* Always verify updates in `db/schema.rb` after running migrations

---

## 2. Migration Commands and Generated Changes

---

### Create Table

```
rails g migration CreateTableBlog title:string:index author:string description:text
```

```ruby
def change
  create_table :blogs do |t|
    t.string :title
    t.string :author
    t.text :description
    t.timestamps
  end

  add_index :blogs, :title
end
```

---

### Create User Table

```
rails g migration CreateTableUser name:string email:string:index
```

```ruby
def change
  create_table :users do |t|
    t.string :name
    t.string :email
    t.timestamps
  end

  add_index :users, :email
end
```

---

### Add Reference

```
rails g migration AddUserReferenceToBlog user:references
```

```ruby
def change
  add_reference :blogs, :user, foreign_key: true
end
```

---

### Add Column with Default and Null Constraint

```
rails g migration AddDescriptionToBlogs description:text default:"No description" null:false
```

```ruby
def change
  add_column :blogs, :description, :text, default: "No description", null: false
end
```

---

### Add Unique Index

```
rails g migration AddUniqueIndexToUsersEmail
```

```ruby
def change
  add_index :users, :email, unique: true
end
```

---

### Remove Column

```
rails g migration RemovePhoneFromUsers phone_no:integer
```

```ruby
def change
  remove_column :users, :phone_no, :integer
end
```

---

### Rename Table

```
rails g migration RenameCommentsToDiscussions
```

```ruby
def change
  rename_table :comments, :discussions
end
```

---

### Drop Table

```
rails g migration DropComments
```

```ruby
def change
  drop_table :comments
end
```

---

### Change Column Datatype

```
rails g migration ChangeDescriptionInBlogs
```

```ruby
def change
  change_column :blogs, :description, :text
end
```

---

### Rollback

```
rails db:rollback
rails db:rollback STEP=2
```

---

## 3. Important Migration Points

* `null: false` prevents NULL values at database level
* `default:` assigns a default value
* `add_index` improves query performance
* `unique: true` prevents duplicate values at database level
* `def change` auto-rollbacks only if the operation is reversible

### 100% Safe Rollback Method (Recommended for Critical Changes)

Use `def up` and `def down` when the change is irreversible or risky.

Example:

```ruby
def up
  change_column :blogs, :description, :text
end

def down
  change_column :blogs, :description, :string
end
```

For dropping tables safely:

```ruby
def up
  drop_table :comments
end

def down
  create_table :comments do |t|
    t.text :content
    t.timestamps
  end
end
```

This guarantees full rollback support.

Important:

* Never edit old migrations after pushing to production
* Always create a new migration for modifications

---

## 4. Datatypes

`String types`: string, text
`Numeric types`: integer, float, decimal
`Date & time types`: date, time, datetime, timestamp
`Other`: binary

---

## 5. Associations

| Association Type        | Relationship      | Third Table | Model Required | Where Used                         |
| ----------------------- | ----------------- | ----------- | -------------- | ---------------------------------- |
| has_one                 | One to One        | No          | No             | Parent model                       |
| has_many                | One to Many       | No          | No             | Parent model                       |
| belongs_to              | Many to One       | No          | No             | Child model (contains foreign key) |
| has_many :through       | Many to Many      | Yes         | Yes            | When join model has logic          |
| has_and_belongs_to_many | Many to Many      | Yes         | No             | Simple join without model          |
| has_one :through        | Strict One to One | Yes         | Yes            | Through another model              |

---

## 6. uniq vs uniqueness vs unique

| Term       | Used In                      | Purpose                                        | Example                                  |
| ---------- | ---------------------------- | ---------------------------------------------- | ---------------------------------------- |
| uniq       | Ruby                         | Removes duplicate values from array            | `[1,1,2].uniq` → `[1,2]`                 |
| uniqueness | Model (Rails validation)     | Prevent duplicate records at application level | `validates :email, uniqueness: true`     |
| unique     | Database (Migration / Index) | Prevent duplicate values at database level     | `add_index :users, :email, unique: true` |

### Where to Use

* Use `uniq` for Ruby collections
* Use `validates :attribute, uniqueness: true` in models
* Use `unique: true` in database index for strong data integrity

---

## 7. Useful Database & Migration Helper Commands

Create database:

```
rails db:create
```

Drop database:

```
rails db:drop
```

Run migrations:

```
rails db:migrate
```

Rollback:

```
rails db:rollback
```

Reset database (drop + create + migrate):

```
rails db:reset
```

Seed data:

```
rails db:seed
```

Reset and seed together:

```
rails db:setup
```

Check migration status:

```
rails db:migrate:status
```
---

# Day 25 : Multi Database + Solid Queue / acync + Active Job 

* Main application data → stored in **Primary Database**
* Background jobs → stored in **Queue Database**
* Active Job → framework that runs tasks in background
* Solid Queue → engine that processes jobs

Example :
When an order is created, a reminder email is scheduled after 7 days.

---

# 1. Configure Multiple Databases

### `config/database.yml`

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  primary:
    <<: *default
    database: ecommerce_development   #--> main app data (orders, users)

  queue:
    <<: *default
    database: ecommerce_development_queue   #-->  background jobs storage
```

* `primary` → used for normal application tables
* `queue` → used only for job tables
* Rails reads this file to know how many databases exist

---

# 2. Create Databases

```bash
rails db:create
```

* Creates both primary and queue databases
* Must run after editing `database.yml`

---

# 3. Install Solid Queue

```bash
rails solid_queue:install
```

created:

* queue configuration files
* job runner (`bin/jobs`)
* queue schema

---

# 4. Run Migrations

```bash
rails db:migrate
```

* Creates tables like `solid_queue_jobs`
* These tables store job status and execution data

If tables are missing:

```bash
rails db:schema:load:queue
```

---

# 5. Set Active Job Adapter

### `config/application.rb`

```ruby
config.active_job.queue_adapter = :solid_queue  # tells Rails to use Solid Queue
```

Points:

* Active Job needs a backend to run jobs
* Solid Queue becomes the processor

---

# 6. Connect Models to Database(example)

### `app/models/application_record.rb`

```ruby
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  connects_to database: {
    writing: :primary,   # insert/update queries
    reading: :primary    # select queries
  }
end
```

* Ensures models interact with correct DB
* If replicas exist, reading can be changed

---

# 7. Generate Background Job

```bash
rails generate job ReviewReminder
```

Creates job file inside `app/jobs`.

---

# 8. Write Job Logic

```ruby
class ReviewReminderJob < ApplicationJob
  queue_as :default   # job stored in default queue

  def perform(customer_id)
    customer = Customer.find(customer_id)  # fetch fresh data
    CustomerMailer.review_reminder(customer).deliver_now  # send email
  end
end
```

* Jobs receive IDs instead of objects
* Code inside `perform` runs in background

---

# 9. Trigger Job from Model

### `app/models/order.rb`

```ruby
class Order < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  after_create_commit :schedule_review_reminder  # runs after order saved

  private

  def schedule_review_reminder
    ReviewReminderJob.set(wait: 7.days).perform_later(customer_id)
  end
end
```


* Callback runs only after database commit
* `perform_later` adds job to queue
* `wait: 7.days` schedules delay

---

# 10. Creating Orders (Controller)

### Method 1

```ruby
@order = Order.new(customer_id: 3, product_id: 5)
@order.save
```

### Method 2

```ruby
@order = Order.new
@order.customer_id = 3
@order.product_id = 5
@order.save
```

* Both create associations before saving
* After save → callback schedules job

---

# 11. Start Job Worker

```bash
bin/jobs
```

* Starts Solid Queue worker
* Worker continuously checks for pending jobs

---

# 12. Test in Rails Console

```ruby
ReviewReminderJob.perform_later(1)  # enqueue job
SolidQueue::Job.last         # check last job
```


* Confirms job creation
* Helps debugging

---

# 13. Mailer View

Create file:

```
app/views/customer_mailer/review_reminder.html.erb
```

* Mailer methods render matching view templates

---

# 14. Flow of Execution

1. User creates order
2. Order saved in primary database
3. Callback runs
4. Job added to queue database
5. Worker picks job
6. Job executes after delay
7. Email sent

---

# 15. Common errors which i got

### Error 1 : `solid_queue_jobs does not exist`

Run:

```bash
rails solid_queue:install
rails db:migrate
```

---

### Error: job not running

Run worker:

```bash
bin/jobs
```

---

## Async vs Solid_Queue (my understanding)

---



| Async                             | Solid Queue                               |
| --------------------------------- | ----------------------------------------- |
| Runs jobs inside the Rails server | Runs jobs using a separate worker process |
| No extra installation needed      | Requires installation and setup           |
| Jobs are stored in memory         | Jobs are stored in the database           |
| Jobs are lost if server stops     | Jobs are safe even if server restarts     |
| Good for small apps and learning  | Good for real projects and production     |
| Not suitable for heavy tasks      | Can handle heavy and important tasks      |
| No need to run extra command      | Must run `bin/jobs` to process jobs       |
---


# Day 25 : Multi Database + Solid Queue / acync + Active Job 

* Main application data → stored in **Primary Database**
* Background jobs → stored in **Queue Database**
* Active Job → framework that runs tasks in background
* Solid Queue → engine that processes jobs

Example :
When an order is created, a reminder email is scheduled after 7 days.

---

# 1. Configure Multiple Databases

### `config/database.yml`

```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  primary:
    <<: *default
    database: ecommerce_development   #--> main app data (orders, users)

  queue:
    <<: *default
    database: ecommerce_development_queue   #-->  background jobs storage
```

* `primary` → used for normal application tables
* `queue` → used only for job tables
* Rails reads this file to know how many databases exist

---

# 2. Create Databases

```bash
rails db:create
```

* Creates both primary and queue databases
* Must run after editing `database.yml`

---

# 3. Install Solid Queue

```bash
rails solid_queue:install
```

created:

* queue configuration files
* job runner (`bin/jobs`)
* queue schema

---

# 4. Run Migrations

```bash
rails db:migrate
```

* Creates tables like `solid_queue_jobs`
* These tables store job status and execution data

If tables are missing:

```bash
rails db:schema:load:queue
```

---

# 5. Set Active Job Adapter

### `config/application.rb`

```ruby
config.active_job.queue_adapter = :solid_queue  # tells Rails to use Solid Queue
```

Points:

* Active Job needs a backend to run jobs
* Solid Queue becomes the processor

---

# 6. Connect Models to Database(example)

### `app/models/application_record.rb`

```ruby
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  connects_to database: {
    writing: :primary,   # insert/update queries
    reading: :primary    # select queries
  }
end
```

* Ensures models interact with correct DB
* If replicas exist, reading can be changed

---

# 7. Generate Background Job

```bash
rails generate job ReviewReminder
```

Creates job file inside `app/jobs`.

---

# 8. Write Job Logic

```ruby
class ReviewReminderJob < ApplicationJob
  queue_as :default   # job stored in default queue

  def perform(customer_id)
    customer = Customer.find(customer_id)  # fetch fresh data
    CustomerMailer.review_reminder(customer).deliver_now  # send email
  end
end
```

* Jobs receive IDs instead of objects
* Code inside `perform` runs in background

---

# 9. Trigger Job from Model

### `app/models/order.rb`

```ruby
class Order < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  after_create_commit :schedule_review_reminder  # runs after order saved

  private

  def schedule_review_reminder
    ReviewReminderJob.set(wait: 7.days).perform_later(customer_id)
  end
end
```


* Callback runs only after database commit
* `perform_later` adds job to queue
* `wait: 7.days` schedules delay

---

# 10. Creating Orders (Controller)

### Method 1

```ruby
@order = Order.new(customer_id: 3, product_id: 5)
@order.save
```

### Method 2

```ruby
@order = Order.new
@order.customer_id = 3
@order.product_id = 5
@order.save
```

* Both create associations before saving
* After save → callback schedules job

---

# 11. Start Job Worker

```bash
bin/jobs
```

* Starts Solid Queue worker
* Worker continuously checks for pending jobs

---

# 12. Test in Rails Console

```ruby
ReviewReminderJob.perform_later(1)  # enqueue job
SolidQueue::Job.last         # check last job
```


* Confirms job creation
* Helps debugging

---

# 13. Mailer View

Create file:

```
app/views/customer_mailer/review_reminder.html.erb
```

* Mailer methods render matching view templates

---

# 14. Flow of Execution

1. User creates order
2. Order saved in primary database
3. Callback runs
4. Job added to queue database
5. Worker picks job
6. Job executes after delay
7. Email sent

---

# 15. Common errors which i got

### Error 1 : `solid_queue_jobs does not exist`

Run:

```bash
rails solid_queue:install
rails db:migrate
```

---

### Error: job not running

Run worker:

```bash
bin/jobs
```

---

## Async vs Solid_Queue (my understanding)

---


| Async                             | Solid Queue                               |
| --------------------------------- | ----------------------------------------- |
| Runs jobs inside the Rails server | Runs jobs using a separate worker process |
| No extra installation needed      | Requires installation and setup           |
| Jobs are stored in memory         | Jobs are stored in the database           |
| Jobs are lost if server stops     | Jobs are safe even if server restarts     |
| Good for small apps and learning  | Good for real projects and production     |
| Not suitable for heavy tasks      | Can handle heavy and important tasks      |
| No need to run extra command      | Must run `bin/jobs` to process jobs       |
---

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
---

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


