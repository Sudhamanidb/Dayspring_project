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
