
# Rails Models: Customer & Product Validations

## 1️--> Customer Model (`Customer < ApplicationRecord`)
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

## 2️ --> Product Model (`Product < ApplicationRecord`)

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




