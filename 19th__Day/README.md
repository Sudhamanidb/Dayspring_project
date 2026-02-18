
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