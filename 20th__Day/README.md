
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



