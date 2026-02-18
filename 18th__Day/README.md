
--
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
# N+1 Query Problem

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

---
* N+1 slows down performance
* Use `includes` to avoid extra queries
* Always check logs for N+1 issues
