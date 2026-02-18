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

### Common Helper Methods
```ruby
p1.offers.empty?
p1.offer_ids
p1.offers.size
p1.offers.exists?(id: 2)
```
### Finding Specific Offers
```ruby
p1.offers.find_by(id: 2)
p1.offers.find_by(off_name: "Unbelievable sale")
```
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
### Updating a Specific Subscription for a Product
```ruby
productObj.subscriptions
          .where(offer_id: 5)
          .update_all(status: 'active')
```
### Updating All Subscriptions Based on Condition

```ruby
productObj.subscriptions.each do |sub|
  sub.update(status: 'expired') if sub.end_date < Date.today
end
```
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
## Task --> Library_management_system (Create demo app and perform all the methods)...

---
