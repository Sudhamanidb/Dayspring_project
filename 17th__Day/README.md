# **Day 17 – References and Methods**
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
